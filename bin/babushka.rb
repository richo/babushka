#!/usr/bin/env ruby

# This file is what gets run when babushka is invoked from the command line.

# First, load babushka itself, by traversing from the actual location of
# this file (it might have been invoked via a symlink in the PATH) to the
# corresponding lib/babushka.rb.

require File.expand_path(
  File.join(
    File.dirname(File.expand_path(
      File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
    )),
    '../lib/babushka'
  )
)

def drop_privileges
  user = Etc.getpwnam(ENV['SUDO_USER'])
  Process::Sys.setuid(user.uid)
  Process::Sys.seteuid(user.uid)
end

def imitate(user)
  ENV['HOME'] = "~#{user}".p.to_s
end

# Mix in the #Dep, #dep & #meta top-level helper methods, since we're running
# standalone.
Object.send :include, Babushka::DSL

# This is a reference implementation. It is not intended to be used in
# production as yet, it is purely a proof of concept and request for comment

if ENV['SUDO_USER']
  read, $sudo_pipe = IO.pipe
  if pid = fork
    read.close
    imitate(ENV['SUDO_USER'])
    drop_privileges
  else
    $sudo_pipe.close
    Babushka::SudoProcess.work(read)
  end
end

# Handle ctrl-c gracefully during babushka runs.
Babushka::Base.exit_on_interrupt!

# Invoke babushka, returning the correct exit status to the shell.
exit !!Babushka::Base.run

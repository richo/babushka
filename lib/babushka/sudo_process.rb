module Babushka
  class SudoProcess
    def self.work(pipe)
      new(pipe).run!
    end

    attr_reader :pipe
    def initialize(pipe)
      @pipe = pipe
    end

    def run!
      # while line = pipe.read
      line = pipe.read
      $stderr.puts "Trying to meet #{line.inspect}"
      Dep(line.chomp).process
      # end
    end
  end
end

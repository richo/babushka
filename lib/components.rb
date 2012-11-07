require 'singleton'

module Babushka
  ExternalComponents = %w[
    fancypath/fancypath
    inkan/inkan
    levenshtein/levenshtein
  ]

  Components = %w[
    core_patches/blank
    core_patches/try
    core_patches/array
    core_patches/hash
    core_patches/hashish
    core_patches/integer
    core_patches/numeric
    core_patches/bytes
    core_patches/object
    core_patches/string
    core_patches/symbol
    core_patches/uri
    xml_string
    helpers/log_helpers
    helpers/shell_helpers
    helpers/path_helpers
    helpers/run_helpers
    helpers/git_helpers
    helpers/uri_helpers
    popen
    shell
    git_repo
    resource
    prompt
    lambda_chooser
    ip
    version_str
    version_of
    accepts_list_for
    accepts_value_for
    accepts_block_for
    colorizer
    cmdline/parser
    cmdline/handler
    cmdline/helpers
    cmdline
    base
    renderable
    system_definitions
    system_profile
    system_detector
    system_matcher
    run_reporter
    bug_reporter
    pkg_helper
    pkg_helpers/unknown_pkg_helper
    pkg_helpers/apt_helper
    pkg_helpers/yum_helper
    pkg_helpers/brew_helper
    pkg_helpers/gem_helper
    pkg_helpers/src_helper
    pkg_helpers/pip_helper
    pkg_helpers/binpkgsrc_helper
    pkg_helpers/binports_helper
    pkg_helpers/npm_helper
    pkg_helpers/pacman_helper
    dsl
    dep
    dep_pool
    task
    source
    source_pool
    vars
    parameter
    path_checker
    dep_definer
    dep_context
    dep_template
    templated_dep_context
  ]
end

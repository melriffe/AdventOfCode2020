# frozen_string_literal: true

require 'bundler/setup'

require 'amazing_print'
require 'pry-byebug'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Enable support for fit, fdescribe and fcontext
  # or :focus metadata
  config.filter_run_when_matching :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Dump out a list of 3 slowest examples
  config.profile_examples = 3
end

def fixtures_path
  File.join(File.dirname(__FILE__), 'fixtures')
end

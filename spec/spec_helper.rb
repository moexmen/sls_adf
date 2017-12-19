# frozen_string_literal: true

require 'coverage_helper'

require 'bundler/setup'
require 'sls_adf'

# Load all files within the support folder
Dir[__dir__ + '/support/**/*'].each { |f| require f if File.file?(f) }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

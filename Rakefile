# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: :spec

require 'rdoc/task'
desc 'Generate documentation for the SLS ADF gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SLS ADF'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.md', 'LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :sls_adf do
  desc 'Get latest ADF schema'
  task :update_schema do
    require 'dotenv'
    require 'sls_adf/util'
    require 'graphql/client'
    require 'sls_adf/configuration'

    Dotenv.load
    SlsAdf.configure do |c|
      c.graphql_url = ENV.fetch('SLS_ADF_GRAPHQL_URL')
      c.get_token_url = ENV.fetch('SLS_ADF_GET_TOKEN_URL')
      c.client_id = ENV.fetch('SLS_ADF_CLIENT_ID')
      c.client_secret = ENV.fetch('SLS_ADF_CLIENT_SECRET')
    end

    schema_location = File.join(File.dirname(__FILE__), 'lib/sls_adf/schema/schema.json')
    GraphQL::Client.dump_schema(SlsAdf::Util::Adapter.new, schema_location)
    puts 'Schema Updated! Did you forget to bump the version?'
  end
end

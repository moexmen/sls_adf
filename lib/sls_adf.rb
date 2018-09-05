# frozen_string_literal: true

require 'sls_adf/version'
require 'sls_adf/configuration'
require 'sls_adf/util'
require 'sls_adf/base'
require 'graphql/client'

module SlsAdf #:nodoc:
  def self.adapter
    @adapter ||= SlsAdf::Util::Adapter.new
  end

  def self.schema
    @schema ||= begin
      path = ENV['SLS_ENV'] == 'dev' ? 'sls_adf/schema/schema.json' : 'sls_adf/schema/schema_old.json'
      schema_path = File.join(File.dirname(__FILE__), path)
      GraphQL::Client.load_schema(schema_path)
    end
  end

  def self.client
    @client ||= GraphQL::Client.new(schema: schema, execute: adapter)
  end
end

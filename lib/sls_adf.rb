# frozen_string_literal: true

require 'sls_adf/version'
require 'sls_adf/configuration'
require 'sls_adf/util'
require 'graphql/client'

module SlsAdf #:nodoc:
  def self.adapter
    @adapter ||= SlsAdf::Util::Adapter.new
  end

  def self.schema
    @schema ||= GraphQL::Client.load_schema(adapter)
  end

  def self.client
    @client ||= GraphQL::Client.new(schema: schema, execute: adapter)
  end
end

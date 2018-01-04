# frozen_string_literal: true

# Provides configuration for the sls_adf gem.
module SlsAdf
  class << self
    attr_accessor :configuration
  end

  # Helper function to configure the sls_adf gem.
  #
  # @yield [configuration] Block to modify the configuration
  # @yieldparam [SlsAdf::Configuration] The configuration object to be modified
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Class to store sls_adf configuration.
  class Configuration
    attr_accessor :graphql_url, :get_token_url, :client_id, :client_secret

    def initialize; end
  end
end

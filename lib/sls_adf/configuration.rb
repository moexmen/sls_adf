# Provides configuration for the sls_adf gem.
module SlsAdf
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :graphql_url, :get_token_url, :client_id, :client_secret

    def initialize; end
  end
end

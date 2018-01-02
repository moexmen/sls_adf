# Defines the method to initialise gem configuration for testing.
module SlsAdf
  def self.initialise_sls_adf_gem!
    SlsAdf.configure do |c|
      c.graphql_url = 'https://p0nmxpxpx0.lp.gql.zone/graphql'
      c.get_token_url = 'https://example.com/token'
      c.client_id = 'test_client_id'
      c.client_secret = 'test_client_secret'
    end
  end
end

SlsAdf.initialise_sls_adf_gem!

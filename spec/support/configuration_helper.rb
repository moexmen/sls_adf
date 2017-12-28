# This helper helps to set the initial values for the gem, and exposes these
# values as variables for use in rspec.

# Initialise gem configuration for testing.
SlsAdf.configure do |c|
  c.graphql_url = 'https://p0nmxpxpx0.lp.gql.zone/graphql'
  c.get_token_url = 'https://example.com/token'
  c.client_id = 'test_client_id'
  c.client_secret = 'test_client_secret'
end

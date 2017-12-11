# Initialise gem configuration for testing.
SlsAdf.configure do |c|
  c.graphql_url = 'http://example.com/graphql'
  c.get_token_url = 'https://example.com/token'
  c.client_id = 'test_client_id'
  c.client_secret = 'test_client_secret'
end

# frozen_string_literal: true

# This helper helps to set the initial values for the gem, and exposes these
# values as variables for use in rspec.

# Initialise gem configuration for testing.
SlsAdf.configure do |c|
  c.graphql_url = 'http://example.com/graphql'
  c.get_token_url = 'https://example.com/token'
  c.client_id = 'test_client_id'
  c.client_secret = 'test_client_secret'
end

# Set the client token for stubbing
module SlsAdf
  CLIENT_TOKEN = 'some_token'
end

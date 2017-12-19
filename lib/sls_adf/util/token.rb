# frozen_string_literal: true
require 'typhoeus'
require 'json'

module SlsAdf::Util
  # Token used to store the ADF API's client credentials token.
  # This is used by +SlsAdf::Util::Adapter+ to make API calls to ADF.
  #
  # The token will be an empty string if:
  #   i) The get_token call is unsuccessful (HTTP status code not 200).
  #   ii) The credentials are invalid.
  class Token
    class << self
      # Returns the token. If no token exists, an API call is made to get the token.
      #
      # @return [String] The ADF API token.
      def token
        @@token ||= get_token
      end

      # Forces an API call to get the token.
      #
      # @return [String] The ADF API token.
      def refresh_token
        @@token = get_token
      end

      private

      # Returns the token after making an API call to get the token.
      # An empty string is returned if:
      #   i) The call is unsuccessful (HTTP status code not 200).
      #   ii) The credentials are invalid.
      #
      # @return [String] The responded token, or an empty string.
      def get_token
        response = get_token_call
        response.code == 200 ? parse_response(response.body) : ''
      end

      # Returns the response for a POST token API call.
      #
      # @return [Typhoeus::Response] The response object.
      def get_token_call
        Typhoeus.post(get_token_url, headers: COMMON_HEADERS, body: body)
      end

      # Attempts to parse the string in Json to obtain the token.
      #
      # @param [String] body String to be parsed
      # @return [String] The parsed token, or blank if an error occurs.
      def parse_response(body)
        token = JSON.parse(body)['data']['token']
        token ? token : ''
      rescue JSON::ParserError
        ''
      end

      def body
        JSON.dump(
          clientId: client_id,
          clientSecret: client_secret,
          grantType: 'client_credentials',
          scope: 'all'
        )
      end

      def client_id
        SlsAdf.configuration.client_id
      end

      def client_secret
        SlsAdf.configuration.client_secret
      end

      def get_token_url
        SlsAdf.configuration.get_token_url
      end
    end
  end
end

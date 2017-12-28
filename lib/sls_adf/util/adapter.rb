# frozen_string_literal: true

require 'typhoeus'
require 'json'

module SlsAdf
  module Util
    # Custom adapter written for github/graphql-client, built to achieve 2 things:
    #   1. Expose HTTP status of response through the #execute method.
    #   2. Automatically GETs token from token endpoint if call is unauthorised.
    #
    # Adapter can be customised with special logic when calling SLS ADF APIs.
    class Adapter
      # GraphQL execution adapter used with the graphql-client library.
      # The Adapter must respond to the execute method with the following method
      # signature.
      #
      # Link: https://github.com/github/graphql-client/blob/master/guides/remote-queries.md
      #
      # @param [GraphQL::Language::Nodes::Document] document The query itself.
      # @param [String] operation_name The name of the operation
      # @param [Hash] variables A hash of the query variables.
      # @param [Hash] context Arbitary hash of values that can be accessed
      # @return [Hash] Parsed API response. Sample shape:
      #   If successful: { 'data' => ... }
      #   If unsuccessful: { 'errors' => ... }
      def execute(document:, operation_name: nil, variables: {}, context: {}) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        body = {}
        # Convert document into query parameters
        body['query'] = document.to_query_string
        body['operationName'] = operation_name if operation_name
        body['variables'] = variables if variables.any?

        headers = context.merge(authorization_header(token.token))
        response = execute_call(headers: headers, body: body)

        if response.code == 401 # Unauthorized
          new_headers = context.merge(authorization_header(token.refresh_token))
          response = execute_call(headers: new_headers, body: body)
        end

        if response.code.zero?
          { errors: [{ message: 'Unable to establish a connection' }] }
        else
          JSON.parse(response.body).merge(http_status: response.code)
        end
      rescue JSON::ParserError
        { errors: [{ message: 'JSON parsing failed' }] }
      end

      private

      # Returns a hash for the autorizatiom key and value.
      #
      # @param [String] token Actual token to be inserted.
      # @return [Hash] Authorization header key and values
      def authorization_header(token)
        { Authorization: 'Bearer ' + token }
      end

      # Executes a HTTP POST call to the specified GraphQL URL.
      #
      # @param [Hash] headers Additional headers to be included, other than
      #   those specified in +SlsAdf::Util::COMMON_HEADERS+.
      # @param [Hash] body The body to be sent in the POST call.
      # @return [Typhoeus::Response] The response object.
      def execute_call(headers: {}, body: {})
        headers = COMMON_HEADERS.merge(headers)
        Typhoeus.post(graphql_url, headers: headers, body: JSON.dump(body))
      end

      # Reference to the Token object. Can be over-written with a custom
      # implementation of the Token object, offering +Token.token+ and
      # +Token.refresh_token+ methods.
      #
      # @return [SlsAdf::Util::Token] The reference to the default token used.
      def token
        @token ||= SlsAdf::Util::Token
      end

      # Reference to the GraphQL URL, which can be over-written.
      #
      # @return [String] The GraphQL URL
      def graphql_url
        @graphql_url ||= SlsAdf.configuration.graphql_url
      end
    end
  end
end

# frozen_string_literal: true

module SlsAdf
  # Base class used to build custom classes to make ADF API calls.
  class Base
    class << self
      protected

      # Helper method used to execute queries.
      #
      # @param [GraphQL::Client::Definition] template The template to be used.
      # @param [Hash] vars Variables to be passed into the query.
      def execute_query(template, vars = {})
        SlsAdf.client.query(template, variables: vars)
      end
    end
  end
end

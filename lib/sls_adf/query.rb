# frozen_string_literal: true

require 'sls_adf/template/query'

module SlsAdf
  # Make GraphQL query calls to SLS ADF through Ruby methods.
  #
  # Sample Usage:
  #   response = SlsAdf::Query.user('User-1234')
  class Query < Base
    class << self
      # Query the information of the context token provided.
      #
      # @param [String] uuid Context token provided through loading of the application.
      # @return [GraphQL::Client::Response] Response of GraphQL call.
      def context(uuid)
        execute_query(SlsAdf::Template::Query::Context, uuid: uuid)
      end

      # Query the information of the user with the given ID.
      #
      # @param [String] id ID of the given user.
      # @return [GraphQL::Client::Response] Response of GraphQL call.
      def user(id)
        execute_query(SlsAdf::Template::Query::User, id: id, first: 10)
      end

      # Query the information of the subject group with the given UUID.
      #
      # @param [String] uuid UUID of the subject group.
      # @return [GraphQL::Client::Response] Response of GraphQL call.
      def subject_group(uuid)
        execute_query(SlsAdf::Template::Query::SubjectGroup,
                      uuid: uuid, first_student: 45, first_teacher: 30)
      end

      # Query the information of the assignment with the given UUID.
      #
      # @param [String] uuid UUID of the assignment.
      # @return [GraphQL::Client::Response] Response of GraphQL call.
      def assignment(uuid)
        execute_query(SlsAdf::Template::Query::Assignment, uuid: uuid)
      end

      # Query the information of the task with the given UUID.
      #
      # @param [String] uuid UUID of the task.
      # @return [GraphQL::Client::Response] Response of GraphQL call.
      def task(uuid)
        execute_query(SlsAdf::Template::Query::Task, uuid: uuid)
      end
    end
  end
end

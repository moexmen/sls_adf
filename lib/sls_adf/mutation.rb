# frozen_string_literal: true

require 'sls_adf/template/mutation'

module SlsAdf
  # Make GraphQL mutation calls to SLS ADF through Ruby methods.
  #
  # Sample Usage:
  #   response = SlsAdf::Mutation.delete_assignment('Assignment-1234')
  class Mutation < Base
    class << self
      # Makes a call to create assignment. assignment_input has the following shape:
      #
      #   {
      #     title: 'Test',
      #     start: '2017-11-30T10:15:30+01:00', #ISO8601 format
      #     end: '2017-12-30T12:15:30Z', #ISO8601 format
      #     createdBy: 'MOE-1234',
      #     type: 'QUIZ',
      #     subjectGroupUuid: 'subject-group-uuid',
      #     assignees: ['MOE-1235', 'MOE-1236', ...]
      #   }
      #
      # @param[Hash] assignment_input
      # @return [GraphQL::Client::Response] The response object
      def create_assignment(assignment_input)
        execute_query(SlsAdf::Template::Mutation::Assignment::Create,
                      assignment_input: assignment_input)
      end

      # Makes a call to update assignment. See #create_assignment for assignment_input shape.
      # If field is null, field will not be updated.
      #
      # @param[Hash] uuid UUID of the subject_group to be modified
      # @param[Hash] assignment_input
      # @return [GraphQL::Client::Response] The response object
      def update_assignment(uuid, assignment_input)
        execute_query(SlsAdf::Template::Mutation::Assignment::Update,
                      uuid: uuid, assignment_input: assignment_input)
      end

      # Makes a call to delete the assignment with the given UUID
      #
      # @param[Hash] uuid UUID of the subject_group to be modified
      # @return [GraphQL::Client::Response] The response object
      def delete_assignment(uuid)
        execute_query(SlsAdf::Template::Mutation::Assignment::Delete, uuid: uuid)
      end

      # Makes a call to update the task. Task status is one of the following:
      #  'NEW', 'IN_PROGRESS', 'COMPLETED'
      #
      # @param[String] uuid UUID of task to be updated
      # @param[String] status Status of the task to be updated
      # @return [GraphQL::Client::Response] The response object
      def update_task(uuid, status)
        execute_query(SlsAdf::Template::Mutation::Task::Update,
                      uuid: uuid, task_status: status)
      end

      # Makes a call to create a notification. notification_input has the following shape:
      #
      #   {
      #     message: 'Assignment 1 has started!',
      #     scope: 'SUBJECT_GROUP', #
      #     scopeId: '', #
      #     eventType: '', #
      #     eventTypeId: '' # UUID,
      #     receipient: ['', '', ...] # User ID.
      #   }
      #
      # @param[Hash] notification_input
      # @return [GraphQL::Client::Response] The response object
      def create_notification(notification_input)
        execute_query(SlsAdf::Template::Mutation::Notification::Add,
                      notification_input: notification_input)
      end
    end
  end
end

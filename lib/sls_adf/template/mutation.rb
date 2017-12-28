# frozen_string_literal: true

require 'sls_adf/template/fragment'

module SlsAdf
  module Template
    module Mutation
      module Assignment
        Create = SlsAdf.client.parse <<~'GRAPHQL'
          mutation($assignment_input: AssignmentInput!) {
            createAssignment(input: $assignment_input) {
              ...SlsAdf::Template::Fragment::Assignment::Fields
            }
          }
        GRAPHQL

        Update = SlsAdf.client.parse <<~'GRAPHQL'
          mutation($uuid: UUID!, $assignment_input: AssignmentInput!) {
            updateAssignment(uuid: $uuid, input: $assignment_input) {
              ...SlsAdf::Template::Fragment::Assignment::Fields
            }
          }
        GRAPHQL

        Delete = SlsAdf.client.parse <<~'GRAPHQL'
          mutation($uuid: UUID!) {
            deleteAssignment(uuid: $uuid)
          }
        GRAPHQL
      end

      module Task
        Update = SlsAdf.client.parse <<~'GRAPHQL'
          mutation($uuid: UUID!, $task_status: TaskStatus!) {
            updateTask(uuid: $uuid, status: $task_status) {
              ...SlsAdf::Template::Fragment::Task::Fields
            }
          }
        GRAPHQL
      end

      module Notification
        Add = SlsAdf.client.parse <<~'GRAPHQL'
          mutation($notification_input: NotificationInput!) {
            createNotification(input: $notification_input) {
              ...SlsAdf::Template::Fragment::Notification::Fields
            }
          }
        GRAPHQL
      end
    end
  end
end

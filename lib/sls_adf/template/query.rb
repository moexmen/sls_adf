# frozen_string_literal: true

require 'sls_adf/template/fragment'

module SlsAdf
  module Template
    module Query
      User = SlsAdf.client.parse <<~'GRAPHQL'
        query($uuid: UUID!, $first: Int = 2) {
          user(uuid: $uuid) {
            ...SlsAdf::Template::Fragment::User::Fields
            subjectGroups(first: $first) {
              ...SlsAdf::Template::Fragment::SubjectGroup::Fields
            }
          }
        }
      GRAPHQL

      SubjectGroup = SlsAdf.client.parse <<~'GRAPHQL'
        query($uuid: UUID!, $first_student: Int = 2, $first_teacher: Int = 2) {
          subjectGroup(uuid: $uuid){
            ...SlsAdf::Template::Fragment::SubjectGroup::Fields
            assignments
            students(first: $first_student, sortField:CLASS_SERIAL_NO) {
              ...SlsAdf::Template::Fragment::User::StudentFields
            }
            teachers(first: $first_teacher) {
              ...SlsAdf::Template::Fragment::User::Fields
            }
          }
        }
      GRAPHQL

      Assignment = SlsAdf.client.parse <<~'GRAPHQL'
        query($uuid: UUID!, $first: Int = 2) {
          assignment(uuid: $uuid){
            ...SlsAdf::Template::Fragment::Assignment::Fields
            createdBy {
              ...SlsAdf::Template::Fragment::User::Fields
            }
            modifiedBy {
              ...SlsAdf::Template::Fragment::User::Fields
            }
            tasks(first: $first) {
              ...SlsAdf::Template::Fragment::Task::Fields
            }
          }
        }
      GRAPHQL

      Task = SlsAdf.client.parse <<~'GRAPHQL'
        query($uuid: UUID!) {
          task(uuid: $uuid) {
            ...SlsAdf::Template::Fragment::Task::Fields
            createdBy {
              ...SlsAdf::Template::Fragment::User::Fields
            }
            assignee {
              ...SlsAdf::Template::Fragment::User::StudentFields
            }
          }
        }
      GRAPHQL

      Context = SlsAdf.client.parse <<~'GRAPHQL'
        query($uuid: UUID!, $first: Int = 15) {
          context(uuid: $uuid) {
            event {
              ...SlsAdf::Template::Fragment::Event::Fields
            }
            user {
              ...SlsAdf::Template::Fragment::User::Fields
              subjectGroups(first: $first) {
                ...SlsAdf::Template::Fragment::SubjectGroup::Fields
              }
            }
          }
        }
      GRAPHQL
    end
  end
end

# frozen_string_literal: true

module SlsAdf
  module Template
    module Fragment
      User = SlsAdf.client.parse <<~'GRAPHQL'
        fragment Fields on User {
          uuid
          name
          role
        }

        fragment StudentFields on User {
          uuid
          name
          classSerialNo
          level
        }
      GRAPHQL

      SubjectGroup = SlsAdf.client.parse <<~'GRAPHQL'
        fragment Fields on SubjectGroup {
          uuid
          code
          subject
        }
      GRAPHQL

      Assignment = SlsAdf.client.parse <<~'GRAPHQL'
        fragment Fields on Assignment {
          uuid
          title
          start
          end
        }
      GRAPHQL

      Task = SlsAdf.client.parse <<~'GRAPHQL'
        fragment Fields on Task {
          uuid
          title
          start
          end
          subject
          status
        }
      GRAPHQL

      Notification = SlsAdf.client.parse <<~'GRAPHQL'
        fragment Fields on Notification {
          message
          scope
          scopeId
          eventType
          eventTypeId
          recipient
        }
      GRAPHQL

      Event = SlsAdf.client.parse <<~'GRAPHQL'
        fragment Fields on Event {
          type
          typeId
        }
      GRAPHQL
    end
  end
end

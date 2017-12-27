# This helper initialises the stubbed version of the Token.
module SlsAdf
  CLIENT_TOKEN = 'some_token'.freeze

  module Util
    class StubbedToken
      class << self
        def token
          SlsAdf::CLIENT_TOKEN
        end

        def refresh_token
          SlsAdf::CLIENT_TOKEN
        end
      end
    end

    class Adapter
      def token
        @token ||= StubbedToken
      end
    end
  end
end

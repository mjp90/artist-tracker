module Songkick
  module Response
    class Account
      def initialize(response:)
        @response = response["results"]["artist"].first
      end

      def serialize
        {
          display_name:  response["displayName"],
          songkick_uid:  response["id"],
          touring_until: response["onTourUntil"],
          url:           response["uri"]
        }
      end

      private
      attr_reader :response
    end
  end
end

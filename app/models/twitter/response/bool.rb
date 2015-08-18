module Twitter
  module Response
    class Bool
      def initialize(response:)
        @response = response
      end

      def serialize
        response
      end

      private
      attr_reader :response
    end
  end
end

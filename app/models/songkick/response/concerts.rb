module Songkick
  module Response
    class Concerts
      def initialize(response:)
        @concerts = response
      end

      def serialize
        concerts.map do |concert|
          Response::Concert.new(response: concert).serialize
        end
      end

      private
      attr_reader :concerts

    end
  end
end

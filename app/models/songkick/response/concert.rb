module Songkick
  module Response
    class Concert
      def initialize(response:)
        @concert = response
      end

      def serialize
        {
          start_date:      start_date,
          city:            city,
          state:           state,
          country:         country,
          age_restriction: concert['ageRestriction'],
          name:            concert['displayName'],
          songkick_uid:    concert['id'],
          url:             concert['uri'],
          lat:             lat,
          long:            long
        }
      end

      private
      attr_reader :concert

      def start_date
        concert['start']['datetime'] ? DateTime.strptime(event['start']['datetime']) : Time.zone.parse(event['start']['date'])
      end

      def location
        @location ||= concert['location']['city'].split(', ')
      end

      def city
        location[0]
      end

      def state
        location[2].nil? ? nil : location[1]
      end

      # If Intl. the state field holds country
      def country
        location[2] || location[1]
      end

      def lat
        concert['venue']['lat']
      end

      def long
        concert['venue']['long']
      end
    end
  end
end

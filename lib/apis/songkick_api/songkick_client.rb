module Apis
  module SongkickApi
    class SongkickClient
      def account_information(identifier:)
        request = Request.new(
          url: account_information_url(identifier: identifier),
          response_formatter: Songkick::Response::Account
        )

        request.send
        request
      end

      # https://www.songkick.com/developer/upcoming-events-for-artist
      def upcoming_concerts(identifier:)
        request = Request.new(
          url: upcoming_concerts_url(identifier: identifier),
          response_formatter: Songkick::Response::Concerts
        )

        request.send
        request
      end

      # http://api.songkick.com/api/3.0/users/{username}/calendar.json?reason=tracked_artist&apikey={your_api_key}
      # This returns any nearby upcoming events from a user's tracked artists
      def shows_near_me

      end

      private

      def account_information_url(identifier:)
        "http://api.songkick.com/api/3.0/search/artists.json?query=#{identifier}&apikey=#{SONGKICK_API_KEY}"
      end

      def upcoming_concerts_url(identifier:)
        "http://api.songkick.com/api/3.0/artists/#{identifier}/calendar.json?apikey=#{SONGKICK_API_KEY}"
      end
    end
  end
end

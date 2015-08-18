module Apis
  module SongkickApi
    module SongkickClient
      def account_information(identifier:)
        url = "http://api.songkick.com/api/3.0/search/artists.json?query=#{identifier}&apikey=#{SONGKICK_API_KEY}"
        results = JSON.parse(RestClient.get(calendar_get_url, nil))["resultsPage"]
      end
    end
  end
end

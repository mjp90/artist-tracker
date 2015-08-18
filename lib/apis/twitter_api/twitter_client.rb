module Apis
  module TwitterApi
    module TwitterClient
      def build_client(access_token:, access_token_secret:)
        ::Twitter::REST::Client.new do |config|
          config.consumer_key        = TWITTER_API_KEY
          config.consumer_secret     = TWITTER_API_SECRET
          config.access_token        = access_token
          config.access_token_secret = access_token_secret
        end
      end
    end
  end
end

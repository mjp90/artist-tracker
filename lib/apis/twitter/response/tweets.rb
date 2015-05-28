module Apis
  module Twitter
    class Response::Tweets
      def initialize(tweets_response:)
        @tweets_response = tweets_response
      end

      def serialize
        tweets_response.map do |tweet_response|          
          Apis::Twitter::Response::Tweet.new(response: tweet_response).serialize
        end
      end

      private
      attr_reader :tweets_response
    end
  end
end

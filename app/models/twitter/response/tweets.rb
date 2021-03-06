module Twitter
  module Response
    class Tweets
      def initialize(response:)
        @tweets_response = response
      end

      def serialize
        tweets_response.map do |tweet_response|
          Response::Tweet.new(response: tweet_response).serialize
        end
      end

      private
      attr_reader :tweets_response
    end
  end
end

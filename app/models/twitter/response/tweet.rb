module Twitter
  module Response
    class Tweet
      def initialize(response:)
        @response   = response
        @mock_tweet = build_mock_tweet
      end

      def serialize
        {
          attachment_url:         mock_tweet.attachment_url,
          favorites_count:        mock_tweet.favorites_count,
          hashtags:               mock_tweet.hashtags,
          is_retweet:             mock_tweet.retweet?,
          language:               mock_tweet.language,
          message:                mock_tweet.message,
          retweet_attachment_url: mock_tweet.retweet_attachment_url,
          retweet_count:          mock_tweet.retweet_count,
          retweet_hashtags:       mock_tweet.retweet_hashtags,
          retweet_user_mentions:  mock_tweet.retweet_user_mentions,
          truncated:              mock_tweet.truncated?,
          tweeted_at:             mock_tweet.tweeted_at,
          twitter_uid:            mock_tweet.twitter_uid,
          user_mentions:          mock_tweet.user_mentions
        }
      end

      def build_mock_tweet
        if response.retweet?
          ::MockRetweet.new(tweet_response: response)
        else
          ::MockTweet.new(tweet_response: response)
        end
      end

      private
      attr_reader :response, :mock_tweet
    end
  end
end

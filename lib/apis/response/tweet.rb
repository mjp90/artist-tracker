module Apis
  module Response
    class Tweet
      attr_reader :tweet_response

      def intialize(tweet_response:)
        @tweet_response = tweet_response
      end

      def serialize
        {
          attachment_url:         attachment_url
          favorites_count:        favorites_count,
          hashtags:               hashtags,
          is_retweet:             tweet_response.retweet?,
          message:                message,
          retweet_attachment_url: retweet_attachment_url,
          retweet_count:          tweet_response.retweet_count,
          retweet_hashtags:       retweet_hashtags,
          retweet_user_mentions:  retweet_user_mentions
          tweeted_at:             tweet_response.created_at, # 2014-06-28 20:41:38 -0700 
          twitter_id:             tweet_response.id.to_s,
          user_mentions:          tweet_user_mentions
        }
      end

      def type
        tweet_response.retweet? ? Retweet.new(tweet_response: tweet_response) : tweet_response
      end
    end

    class Retweet
      attr_reader :tweet_response

      def intialize(tweet_response:)
        @tweet_response = tweet_response
      end
    end
  end
end

module Apis
  module Response
    class Tweets
      attr_reader :tweets_response

      def initialize(tweets_response:)
        @tweets_response = tweets_response
      end

      def serialize
        tweets_response.map do |tweet_response|
          Apis::Response::Tweet.new(tweet_response: tweet_response).serialize
        end
      end

      def retweet?
        tweets_response.retweet?
      end

      def attachment_url
        tweets_response.media.first && tweets_response.media.first.media_url.to_s
      end

      def favorites_count
        if retweet?
          tweets_response.retweeted_status.favorite_count
        else
          tweets_response.favorite_count
        end
      end

      def hashtags
        if retweet?
          tweet_hashtags - tweets_response.retweeted_status.hashtags
        else
          tweet_hashtags
        end
      end

      def tweet_hashtags
        tweets_response.hashtags.map{ |ht| ht.text }
      end

      def message
        tweets_response.text.encode("iso-8859-1", undef: :replace, replace: '')
      end

      def retweet_attachment_url
        tweets_response.retweeted_status.media.first && tweets_response.retweeted_status.media.first.media_url if retweet?
      end

      def retweet_hashtags
        tweets_response.retweeted_status.hashtags.map{ |ht| ht.text } if retweet?
      end

      def retweet_user_mentions
        tweets_response.retweeted_status.user_mentions.map{ |um| um.screen_name } if retweet?
      end

      def user_mentions
        if retweet?
          tweet_user_mentions - retweet_user_mentions
        else
          tweet_user_mentions
        end
      end

      def tweet_user_mentions
        tweets_response.user_mentions.map{ |um| um.screen_name }
      end
    end
  end
end

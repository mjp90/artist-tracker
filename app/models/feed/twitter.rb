module Feed
  class Twitter
    def initialize(artist:)
      @artist = artist
      @client = Apis::Twitter::Client::ApplicationClient.new
    end

    def refresh
      update_account
      update_tweets
    end

    private
    attr_reader :artist, :client

    def account
      @account || artist.twitter_account
    end

    def update_account
      formatted_account_info = Apis::Twitter::Response::AccountInformation.new(
        response: client.account_info(uid: account.twitter_uid.to_i)
      ).serialize

      account.update(formatted_account_info)
    end

    def update_tweets
      formatted_tweet_collection = Apis::Twitter::Response::Tweets.new(
        tweets_response: client.tweets(uid: account.twitter_uid.to_i, options: nil)
      ).serialize

      formatted_tweet_collection.each do |formatted_tweet|
        account.tweets.where(twitter_id: formatted_tweet[:twitter_uid]).first_or_create(formatted_tweet)
      end

      # Remove tweets that are no longer recent
      account.tweets.where.not(twitter_id: formatted_tweet_collection.map(&:twitter_uid)).destroy_all
    end
  end
end

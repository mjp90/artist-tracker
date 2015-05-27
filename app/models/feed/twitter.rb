module Feed
  class Twitter
    def initialize(artist: artist)
      
    end

    def self.refresh_for_artist(artist_id)
      artist = Artist.find(artist_id)


      user_info = Apis::Twitter.new(uid: artist.twitter_uid).user_info
      artist.twitter_account.update(user_info)

      refresh_account(artist)
      refresh_tweets(artist)
    end

    def self.refresh_account(artist)
      user_info = Apis::Twitter.new(uid: artist.twitter_uid).user_info

      artist.twitter_account.update(user_info)
    end

    def self.refresh_tweets(artist)
      tweets = Apis::Twitter.new(uid: artist.twitter_uid).tweets

      tweets.each do |tweet_info|
        refresh_tweet(tweet_info)
      end

      artist.tweets.where.not(twitter_id: tweets.pluck[:twitter_id]).destroy_all
    end

    def self.refresh_tweet(tweet_info)
      tweet = Tweet.where(twitter_id: tweet_info[:twitter_id]).first_or_create

      tweet.update(tweet_info)
    end
  end
end

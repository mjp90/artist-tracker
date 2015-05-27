class TwitterFeed
  def initialize(artist: artist)
    @artist = artist
    @client = Apis::TwitterApplicationClient.new
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
    formatted_account_info = TwitterResponse::AccountInfo.formatted_response(response: client.account_info)

    account.update(formatted_account_info)
  end

  def update_tweets
    formatted_tweet_collection.each do |formatted_tweet|
      account.tweets.find_or_create(Twitter::)
    end

    # Remove tweets that are no longer recent
    account.tweets.where.not(twitter_id: formatted_tweet_collection.map(&:id)).destroy_all
  end

  def formatted_tweet_collection
    @formatted_tweet_collection ||= FormatterType2.formatted_response(response: client.tweets)
  end
    
  end
end

def FormatterType
  def self.format(response:)
    {
      a: response[:x]
    }
  end
end

class TwitterAccountInfo
  def self.formatted_for_update(response:)
    
  end

  def method_name
    
  end
end

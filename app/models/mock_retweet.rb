class MockRetweet < MockTweet
  def initialize(tweet_response:)
    @tweet_response = tweet_response
  end

  def retweet?
    true
  end

  def favorite_count
    tweet_response.retweeted_status.favorite_count
  end

  def hashtags
    tweet_hashtags - tweet_response.retweeted_status.hashtags
  end

  def retweet_attachment_url
    tweet_response.retweeted_status.media.first && tweet_response.retweeted_status.media.first.media_url
  end

  def retweet_hashtags
    tweet_response.retweeted_status.hashtags.map{ |ht| ht.text }
  end

  def retweet_user_mentions
    tweet_response.retweeted_status.user_mentions.map{ |um| um.screen_name }
  end

  def user_mentions
    tweet_user_mentions - retweet_user_mentions
  end

  private
  attr_reader :tweet_response
end

class MockTweet
  def intialize(tweet_response:)
    @tweet_response = tweet_response
  end

  def retweet?
    false
  end

  def attachment_url
    tweet_response.media.first && tweet_response.media.first.media_url.to_s
  end

  def favorite_count
    tweet_response.favorite_count
  end

  def hashtags
    tweet_hashtags
  end

  def language
    tweet_response.lang
  end

  def message
    tweet_response.text.encode("iso-8859-1", undef: :replace, replace: '')
  end

  def retweet_attachment_url
    nil
  end

  def retweet_count
    tweet_response.retweet_count
  end

  def retweet_hashtags
    nil
  end

  def retweet_user_mentions
    nil
  end

  def truncated?
    tweet_response.truncated?
  end

  # 2014-06-28 20:41:38 -0700 
  def tweeted_at
    tweet_response.created_at
  end

  def twitter_uid
    tweet_response.id.to_s
  end

  def user_mentions
    tweet_user_mentions
  end

  private
  attr_reader :tweet_response

  def tweet_hashtags
    tweet_response.hashtags.map{ |ht| ht.text }
  end

  def tweet_user_mentions
    tweet_response.user_mentions.map{ |um| um.screen_name }
  end
end

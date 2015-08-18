class TwitterFeed
  def self.refresh_for_artist(artist_id)
    artist = Artist.find(artist_id)
    TwitterFeed.new.refresh_account(artist.twitter_account)
    # if AppTwitterRateLimitStatus.
    # Feeds::Twitter.new(artist: artist).refresh
  end

  def refresh_account(twitter_account)
    request = TwitterRequest.new(twitter_account: twitter_account)
    request.refresh_artist_account
    binding.pry
    request.refresh_artist_tweets
  end
end

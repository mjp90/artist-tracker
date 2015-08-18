class TwitterFeed
  def self.refresh_for_artist(artist_id)
    artist = Artist.find(artist_id)

    # if AppTwitterRateLimitStatus.
    Feed::Twitter.new(artist: artist).refresh
  end
end

class ArtistFeeds
  def self.refresh
    # TODO: Grab Artists in Order of last updated_at by Twitter Account
    Artist.all.each do |artist|
      TwitterJob.enqueue(TwitterFeed, :refresh_for_artist, artist.id)
    end
  end
end

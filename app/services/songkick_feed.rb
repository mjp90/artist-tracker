class SongkickFeed
  def self.refresh_for_artist(artist_id)
    artist = Artist.find(artist_id)
    SongkickFeed.new.refresh_account(artist.songkick_account)
  end

  def refresh_account(songkick_account)
    request = SongkickRequest.new(songkick_account: songkick_account)
    request.refresh_artist_account
    request.refresh_artist_concerts
  end
end

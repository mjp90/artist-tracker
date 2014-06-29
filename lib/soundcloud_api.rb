class SoundcloudApi

  def self.client
    @client ||= Soundcloud.new(:client_id => "#{SOUNDCLOUD_API_KEY}")
  end

  def self.get_account_info_for_owner(owner)
    response     = client.get('/resolve', :url => owner.soundcloud_url)
    account_info = self.extract_account_info(response)
  end

  def self.get_tracks_for_account(account)
    response = client.get("/users/#{account.soundcloud_id}/tracks")
    tracks   = []

    response.each do |track|
      tracks << self.extract_track_info(track) if track.sharing == 'public'
    end

    tracks
  end

  def self.get_embedded_audio_player(track)
    client.get('/oembed', :url => track.url)['html']
  end

  def self.extract_account_info(response)
    {
      :api_url         => response.uri,
      :avatar_url      => response.avatar_url,
      :city            => response.city,
      :country         => response.country,
      :display_name    => response.username,
      :soundcloud_id   => response.id,
      :total_followers => response.followers_count,
      :total_following => response.followings_count,
      :total_tracks    => response.track_count,
      :url             => response.permalink_url
    }
  end

  def self.extract_track_info(track)
    {
      :artwork_url     => track.artwork_url,
      :comments_count  => track.comment_count,
      :download_count  => track.download_count,
      :download_url    => track.download_url,
      :duration        => track.duration,
      :favorited_count => track.favoritings_count,
      :genre           => track.genre,
      :is_commentable  => track.commentable,
      :is_downloadable => track.downloadable,
      :playback_count  => track.playback_count,
      :purchase_url    => track.purchase_url,
      :soundcloud_id   => track.id,
      :is_streamable   => track.streamable,
      :stream_url      => track.stream_url,
      :title           => track.title,
      :uploaded_date   => track.created_at,
      :url             => track.permalink_url,
      :waveform_url    => track.waveform_ur
    }
  end
end

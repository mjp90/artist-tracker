# == Schema Information
#
# Table name: tracks
#
#  id                    :integer          not null, primary key
#  soundcloud_account_id :integer
#  soundcloud_id         :integer          not null
#  playback_count        :integer
#  download_count        :integer
#  comments_count        :integer
#  favorited_count       :integer
#  duration              :integer
#  genre                 :string(255)
#  purchase_url          :text
#  title                 :text             not null
#  url                   :text
#  artwork_url           :text
#  waveform_url          :text
#  stream_url            :text
#  download_url          :text
#  embedded_html         :text
#  uploaded_date         :datetime         not null
#  is_commentable        :boolean          not null
#  is_downloadable       :boolean          not null
#  is_streamable         :boolean          not null
#  created_at            :datetime
#  updated_at            :datetime
#
# Indexes
#
#  index_tracks_on_soundcloud_account_id  (soundcloud_account_id)
#

class Track < ActiveRecord::Base
  belongs_to :soundcloud_account

  def get_embedded_html
    embedded_html = SoundcloudApi.get_embedded_audio_player(self)
    self.update_column(:embedded_html, embedded_html)
  end
end

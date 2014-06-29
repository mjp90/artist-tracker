# == Schema Information
#
# Table name: soundcloud_accounts
#
#  id                 :integer          not null, primary key
#  account_owner_id   :integer
#  account_owner_type :string(255)
#  soundcloud_id      :integer          not null
#  total_tracks       :integer
#  total_followers    :integer
#  total_following    :integer
#  display_name       :string(255)      not null
#  country            :string(255)
#  city               :string(255)
#  api_url            :text
#  url                :text             not null
#  avatar_url         :text
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  soundcloud_accounts_on_account_owner_idx  (account_owner_id,account_owner_type) UNIQUE
#

class SoundcloudAccount < ActiveRecord::Base
  belongs_to :account_owner, :polymorphic => true
  has_many   :tracks, :dependent => :destroy

  def self.create_account_for_owner(owner)
    fetched_account_info = SoundcloudApi.get_account_info_for_owner(owner)
    owner.create_soundcloud_account(fetched_account_info)
  end

  def update_tracks
    found_tracks_info = SoundcloudApi.get_tracks_for_account(self)
    current_track_ids = self.tracks.pluck(:id)
    found_track_ids   = found_tracks_info.map { |t| t[:soundcloud_id] }

    found_tracks_info.each do |track_info|
      if current_track_ids.include?(track_info[:soundcloud_id]) 
        self.tracks.update_attributes(track_info)
      else 
        track = self.tracks.create!(track_info)
        # track.get_embedded_html
      end
    end

    deleted_tracks = current_track_ids - found_track_ids
    if deleted_tracks.count > 0
      self.tracks.where(:id => deleted_tracks).destroy_all
      self.total_tracks -= deleted_tracks.count
      save!
    end
  end
end

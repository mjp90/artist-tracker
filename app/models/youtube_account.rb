class YoutubeAccount < ActiveRecord::Base
  belongs_to :account_owner, :polymorphic => true
  has_many   :videos, :dependent => :destroy

  def self.create_account_for_owner(owner)
    fetched_account_info = YoutubeApi.get_account_info_for_owner(owner)
    owner.create_youtube_account(fetched_account_info)
  end

  def update_videos
    found_videos = YoutubeApi.videos_for_account(self)

    existing_video_ids = self.videos.pluck(:youtube_id)
    found_video_ids    = found_videos.map { |t| t[:youtube_id] }
    new_video_ids      = found_video_ids - existing_video_ids
    deleted_video_ids  = existing_video_ids - found_video_ids
    present_video_ids  = found_video_ids - new_video_ids
    videos_to_update   = self.videos.where(:youtube_id => present_video_ids)

    if new_video_ids.any?
      new_videos = found_videos.pop(new_video_ids.count)
      new_videos.each do |new_video|
        self.videos.create!(new_videos)
      end
    end

    videos_to_update.each do |video|
      video.update_attributes(found_videos.shift)
    end

    if deleted_video_ids.any?
      self.videos.where(:youtube_id => deleted_video_ids).destroy_all
    end

    save! # Done with updating so need to update updated_at time
  end

end
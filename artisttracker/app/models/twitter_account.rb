class TwitterAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist
  has_many   :tweets

  def self.create_new_for_artist(fetched_account, artist)
    account_info = extract_account_info(fetched_account)
    TwitterAccount.create(account_info.merge{:artist_id => artist.id})
  end

  def extract_account_info(fetched_account)
    {
      :username => fetched_account.name,
      :screen_name => fetched_account.screen_name,
      :tagline => fetched_account.description,
      :location => fetched_account.location,
      :language => fetched_account.lang,
      :profile_pic_url => fetched_account.profile_background_image_url,
      :join_date => fetched_account.created_at,
      :statuses_count => fetched_account.statuses_count,
      :followers_count => fetched_account.followers_count
    }
  end
end
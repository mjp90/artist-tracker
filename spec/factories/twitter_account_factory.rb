# == Schema Information
#
# Table name: twitter_accounts
#
#  id                           :integer          not null, primary key
#  account_owner_id             :integer
#  account_owner_type           :string(255)
#  statuses_count               :integer
#  followers_count              :integer
#  friends_count                :integer
#  favorites_count              :integer
#  twitter_uid                  :text             not null
#  oauth_token                  :string(255)
#  oauth_secret                 :string(255)
#  username                     :string(255)      not null
#  location                     :string(255)
#  language                     :string(255)
#  profile_background_color     :string(255)
#  profile_background_image_url :text
#  profile_banner_url           :text
#  tagline                      :text
#  profile_pic_url              :text
#  verified                     :boolean
#  join_date                    :datetime
#  created_at                   :datetime
#  updated_at                   :datetime
#  display_name                 :text
#  profile_link_color           :text
#  profile_use_background_image :boolean
#  status                       :text
#  time_zone                    :text
#  url                          :text
#
# Indexes
#
#  twitter_accounts_on_account_owner_idx  (account_owner_id,account_owner_type) UNIQUE
#

FactoryGirl.define do
  factory :twitter_account do
    username 'tweetman1'
  end
end

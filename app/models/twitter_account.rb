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

class TwitterAccount < ActiveRecord::Base
  belongs_to :account_owner, polymorphic: true
  has_many   :tweets, dependent: :destroy

  def self.create_account_for_owner(owner)
    fetched_account_info = TwitterApi.get_account_info_for_owner(owner)
    owner.create_twitter_account(fetched_account_info)
  end

  def update_tweets(tweets_response)
    tweets_response.each do |tweet_response|
      tweets.where(twitter_uid: tweet_response[:twitter_uid]).first_or_create(tweet_response)
    end

    Tweet.truncate_tweets(twitter_account: self, tweet_uids: tweets_response.map { |tr| tr[:twitter_uid] })
  end

  def self.find_for_oauth(auth)
    where(auth.slice(:uid)).first_or_create do |twitter_account|
      twitter_account.uid = auth.uid
      twitter_account.username = auth.name
      # ...
      # twitter_account.save!
    end
  end

  def user?
    account_owner.is_a?(User)
  end
end

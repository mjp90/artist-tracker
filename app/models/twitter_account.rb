# == Schema Information
#
# Table name: twitter_accounts
#
#  id                           :integer          not null, primary key
#  account_owner_id             :integer
#  account_owner_type           :string(255)
#  twitter_id                   :integer          not null
#  statuses_count               :integer
#  followers_count              :integer
#  friends_count                :integer
#  favorites_count              :integer
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
#
# Indexes
#
#  twitter_accounts_on_account_owner_idx  (account_owner_id,account_owner_type) UNIQUE
#

class TwitterAccount < ActiveRecord::Base
  belongs_to :account_owner, :polymorphic => true
  has_many   :tweets, :dependent => :destroy


  def self.create_account_for_owner(owner)
    fetched_account_info = TwitterApi.get_account_info_for_owner(owner)
    owner.create_twitter_account(fetched_account_info)
  end

  def update_tweets
    puts "update_tweets"
    found_tweets = TwitterApi.tweets_for_account(self)

    existing_tweet_ids = self.tweets.pluck(:twitter_id)
    found_tweet_ids    = found_tweets.map { |t| t[:twitter_id] }
    new_tweet_ids      = found_tweet_ids - existing_tweet_ids
    deleted_tweet_ids  = existing_tweet_ids - found_tweet_ids
    present_tweet_ids  = found_tweet_ids - new_tweet_ids
    tweets_to_update   = self.tweets.where(:twitter_id => present_tweet_ids)

    if new_tweet_ids.any?
      new_tweets = found_tweets.pop(new_tweet_ids.count)
      new_tweets.each do |new_tweets|
        self.tweets.create!(new_tweets)
      end
    end

    tweets_to_update.each do |tweet|
      tweet.update_attributes(found_tweets.shift)
    end

    if deleted_tweet_ids.any?
      self.tweets.where(:twitter_id => deleted_tweet_ids).destroy_all
    end

    save! # Done with updating so need to update updated_at time
  end

  def self.find_for_oauth(auth)
    where(auth.slice(:uid)).first_or_create do |twitter_account|
      twitter_account.uid = auth.uid
      twitter_account.username = auth.name
      # ...
      # twitter_account.save!
    end
  end
end

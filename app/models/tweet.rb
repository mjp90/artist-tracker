# == Schema Information
#
# Table name: tweets
#
#  id                     :integer          not null, primary key
#  twitter_account_id     :integer          not null
#  retweet_count          :integer
#  favorites_count        :integer
#  is_retweet             :boolean
#  twitter_uid            :string(255)      not null
#  retweet_hashtags       :string           is an Array
#  retweet_user_mentions  :string           is an Array
#  hashtags               :string           is an Array
#  user_mentions          :string           is an Array
#  message                :text
#  attachment_url         :text
#  retweet_attachment_url :text
#  tweeted_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  language               :text
#  truncated              :boolean
#
# Indexes
#
#  index_tweets_on_twitter_account_id  (twitter_account_id)
#

class Tweet < ActiveRecord::Base
  belongs_to :twitter_account, :touch => true

  default_scope { order('id asc') }
  scope :min_tweet, -> { min(:id) }

  def self.truncate_tweets(twitter_account:, tweet_uids:)
    twitter_account.tweets.where.not(twitter_uid: tweet_uids).destroy_all
  end
end

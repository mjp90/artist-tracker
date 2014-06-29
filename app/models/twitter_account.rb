# == Schema Information
#
# Table name: twitter_accounts
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  artist_id       :integer
#  statuses_count  :integer
#  followers_count :integer
#  username        :string(255)
#  location        :string(255)
#  language        :string(255)
#  tagline         :text
#  profile_pic_url :text
#  join_date       :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  twitter_accounts_artist_id_idx  (artist_id)
#  twitter_accounts_user_id_idx    (user_id)
#

class TwitterAccount < ActiveRecord::Base
  # include TwitterApi
  # include ApiParamsExtractor

  belongs_to :user
  belongs_to :artist
  has_many   :tweets

  def self.find_for_oauth(auth)
    where(auth.slice(:uid)).first_or_create do |twitter_account|
      twitter_account.uid = auth.uid
      twitter_account.username = auth.name
      # ...
      # twitter_account.save!
    end
  end

  def self.create_for_artist(artist)
    # fetched_account      = TwitterApi::Methods.get_account_for_username(artist.name)
    # fetched_account_info = ApiParamsExtractor::Twitter.extract_account_info(fetched_account)
    # twitter_account      = create(fetched_account_info.merge(:artist_id => artist.id)

    # found_tweets = TwitterApi::Methods.tweets_for_account(twitter_account)
    # found_tweets.each do |tweet|
    #   tweet_info = ApiParamsExtractor::Twitter.extract_tweet_info(tweet)
    #   Tweet.create(tweet_info.merge(:twitter_account_id => twitter_account.id))
    # end
  end

  def update_info
    # fetched_account      = TwitterApi::Methods.get_account_for_username(screen_name)
    # fetched_account_info = ApiParamsExtractor::Twitter.extract_account_info(fetched_account)
    # # if nothing has changed for the account (Same Tweets Count Or Something. Maybe Updated at) don't need to update
    # self.update_attributes(fetched_account_info)

    # # Wipe out existing?
    # # Only grab new ones? Don't know how tweets are updated
    # found_tweets = TwitterApi::Methods.tweets_for_account(self, self.tweets.min_twitter_id)
    # found_tweets.reject!{|tweet| Tweet.where(:twitter_id => tweet.id)}      
    # found_tweets.each do |tweet|
    #   tweet_info = ApiParamsExtractor::Twitter.extract_tweet_info(tweet)
    #   Tweet.create(tweet_info.merge(:twitter_account_id => self.id))
    # end
  end
end

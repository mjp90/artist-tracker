# require 'twitter_api'

class Artist < ActiveRecord::Base

  # include TwitterApi

  has_one :twitter_account
  # has_one :facebook_feed
  # has_one :soundcloud_feed
  # has_one :songkick_feed
  has_and_belongs_to_many :users, :join_table => :users_artists

  def self.update_next_artist_feed
    artist = Artist.order(:updated_at).first
    fetched_twitter_account = get_account_for_username(artist.name)
    current_twitter_account = artist.twitter_account
    if current_twitter_account.exists? 
      current_twitter_account.update_info(fetched_twitter_account)
    else 
      TwitterAccount.create_new_for_artist(fetched_twitter_account, artist)
    end
  end

end

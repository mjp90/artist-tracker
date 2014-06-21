# require 'twitter_api'

class Artist < ActiveRecord::Base

  # include TwitterApi

  validates :name, :music_genre, :presence => true
  validates :name, :uniqueness => {:scope => :music_genre}

  has_one :twitter_account
  # has_one :facebook_feed
  # has_one :soundcloud_feed
  # has_one :songkick_feed
  has_and_belongs_to_many :users, :join_table => :users_artists

  def self.update_next_artist_feed
    artist = Artist.order(:updated_at).first

    artist.twitter_account.update_info
    # fetched_twitter_account = get_account_for_username(artist.name)
    # current_twitter_account = artist.twitter_account
    # if current_twitter_account.exists? 
    #   current_twitter_account.update_info(fetched_twitter_account)
    # else 
    #   TwitterAccount.create_for_artist(fetched_twitter_account, artist)
    # end
  end

  def self.add_new(info)
    artist = create(info)

    TwitterAccount.create_for_artist(artist)

    # artist.create_twitter_account
    # artist.create_facebook_account
    # artist.create_soundcloud_account
    # artist.create_songkick_account
  end

  # def create_twitter_account
  #   TwitterAccount.
  # end
end

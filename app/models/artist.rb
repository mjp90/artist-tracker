# == Schema Information
#
# Table name: artists
#
#  id             :integer          not null, primary key
#  twitter_url    :text
#  facebook_url   :text
#  soundcloud_url :text
#  songkick_url   :text
#  name           :string(255)      not null
#  music_genre    :string(255)      not null
#  country        :string(255)
#  city           :string(255)
#  state          :string(255)
#  age            :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_artists_on_name_and_music_genre  (name,music_genre) UNIQUE
#

class Artist < ActiveRecord::Base
  has_one :twitter_account,    :as => :account_owner, :dependent => :destroy
  has_one :facebook_account,   :as => :account_owner, :dependent => :destroy
  has_one :soundcloud_account, :as => :account_owner, :dependent => :destroy
  has_one :songkick_account,   :as => :account_owner, :dependent => :destroy

  has_many :tweets,   :through => :twitter_account
  has_many :posts,    :through => :facebook_account
  has_many :tracks,   :through => :soundcloud_account
  has_many :concerts, :through => :songkick_account

  has_and_belongs_to_many :users, :join_table => :users_artists
  
  validates :name, :music_genre, :presence => true
  validates :name, :uniqueness => {:scope => :music_genre}


  ####################################################################################################
  ############################## UPDATE SONGKICK METHODS #############################################
  ####################################################################################################

  def self.update_all_songkick_accounts
    Artist.all.each do |artist|
      songkick_account = artist.songkick_account
      unless artist.songkick_account.present?
        songkick_id = artist.songkick_url.split('-')[0].split('/').last
        songkick_account = SongkickAccount.create!(:songkick_id => songkick_id, :artist_id => artist.id, :display_name => artist.name)
      end 

      songkick_account.update_upcoming_concerts
    end
  end

  def update_songkick_feed
    songkick_account = self.songkick_account
    unless songkick_account.present?
      songkick_id = self.songkick_url.split('-')[0].split('/').last
      songkick_account = self.create_songkick_account(:songkick_id => songkick_id, :display_name => self.name)
    end 

    songkick_account.update_concerts
  end


  ####################################################################################################
  ############################## UPDATE SOUNDCLOUD METHODS ###########################################
  ####################################################################################################

  def update_soundcloud_feed
    soundcloud_account = self.soundcloud_account
    unless soundcloud_account.present?
      soundcloud_account = SoundcloudAccount.create_account_for_owner(self)
    end

    soundcloud_account.update_tracks
  end


  ####################################################################################################
  ############################## UPDATE TWITTER METHODS ##############################################
  ####################################################################################################

  def update_twitter_feed
    twitter_account = self.twitter_account
    unless twitter_account.present?
      twitter_account = TwitterAccount.create_account_for_owner(self)
    end

    twitter_account.update_tweets
  end


  ####################################################################################################
  ############################## UPDATE FACEBOOK METHODS #############################################
  ####################################################################################################

  def update_facebook_feed
    facebook_account = self.facebook_account
    unless facebook_account.present?
      facebook_account = FacebookAccount.create_account_for_owner(self)
    end

    facebook_account.update_posts
  end


  def self.update_next_artist_feed
    artist = Artist.order(:updated_at).first
  end

  ########################## SUPER METHODS ###########################
  ####################################################################

  def self.extract_all_songkick_artist_ids
    Artist.all.each do |artist|
      unless artist.songkick_id
        songkick_id = artist.songkick_url.split('-')[0].split('/').last
        artist.update_attributes(:songkick_id => songkick_id)
      end
    end
  end
end

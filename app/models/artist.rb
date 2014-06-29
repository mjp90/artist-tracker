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
  has_one :twitter_account
  # has_one :facebook_feed
  has_one :soundcloud_account, :as => :account_owner, :dependent => :destroy
  has_one :songkick_account, :dependent => :destroy
  has_and_belongs_to_many :users, :join_table => :users_artists
  has_many :tracks, :through => :soundcloud_account

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
      songkick_account = SongkickAccount.create!(:songkick_id => songkick_id, :artist_id => self.id, :display_name => self.name)
    end 

    songkick_account.update_upcoming_concerts
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

class ArtistsController < ApplicationController

  def index
    
  end

  def show
    @artist = current_user.artists.where(:id => params[:id]).take
    head :not_found unless @artist

    @artist_twitter_account    = @artist.twitter_account
    @artist_facebook_account   = @artist.facebook_account
    @artist_soundcloud_account = @artist.soundcloud_account
    # binding.pry
    # @artist_songkick_account   = SongkickAccount.preload(:concerts).where(:account_owner => @artist).take
    @artist_songkick_account   = @artist.songkick_account
  end

  def show_twitter_feed
    
  end

  def show_facebook_feed
    
  end

  def show_soundcloud_feed
    
  end

  def show_songkick_feed
    
  end
end

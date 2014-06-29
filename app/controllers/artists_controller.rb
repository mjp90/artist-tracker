class ArtistsController < ApplicationController

  def index
    
  end

  def show
    @artist = current_user.artists.where(:id => params[:id]).take
    head :not_found unless @artist
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

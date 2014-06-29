
class AdminManagerController < ApplicationController
  # include TwitterApi

  def home
    @artist = Artist.new
  end

  def find_artist_info
    # Web Scraper to scrape wikipedia for info?    
  end

  def create_artist
    # Artist.add_new(params[:info])
    # binding.pry
    @artist = Artist.create(artist_params)
    if @artist.save
      flash[:notice] = "Artist Successfully Created" and redirect_to admin_manager_home_path
    else
      flash[:error] = @artist.errors.full_messages and render :home
    end
  end

  def update_artist_songkick_accounts
    Artist.update_all_songkick_accounts
    
    SongkickAccount.update_all_accounts
    # SongkickApi.get_upcoming_concerts_for_user
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :music_genre, :twitter_url, :facebook_url, :soundcloud_url, :songkick_url)
  end
end

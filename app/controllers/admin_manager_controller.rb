class AdminManagerController < ApplicationController
  # include TwitterApi

  def home
    
  end

  def find_artist_info
    # Web Scraper to scrape wikipedia for info?    
  end

  def create_artist
    Artist.add_new(params[:info])
  end
end

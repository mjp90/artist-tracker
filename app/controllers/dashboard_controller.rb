class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to dashboard_show_path
  end

  def show
    @artists = current_user.artists
  end

  def create_temp_artist
    Artist.create!(:name => 'Zedd', :country => 'Germany', :city => 'Kaiserslautern', :music_genre => 'Electro House', :age => '24',
      :twitter_url => "http://twitter.com/zedd", :facebook_url => "http://www.facebook.com/Zedd", :soundcloud_url => "http://soundcloud.com/zedd", 
      :songkick_url => "http://www.songkick.com/artists/992104-zedd")


    redirect_to dashboard_show_path
  end
end

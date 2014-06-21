class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to dashboard_show_path
  end

  def show
    @artists = current_user.artists
  end

  def create_temp_artist
    Artist.create!(:name => 'Zedd', :country => 'Germany', :city => 'Kaiserslautern', :music_genre => 'Electro House', :age => '24')

    redirect_to dashboard_show_path
  end
end

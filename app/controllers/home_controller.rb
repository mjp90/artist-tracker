class HomeController < ApplicationController
  def index
    redirect_to dashboard_show_path if user_signed_in?
  end
end

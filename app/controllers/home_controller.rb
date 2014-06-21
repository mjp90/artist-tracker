class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    redirect_to dashboard_show_path if user_signed_in?
  end
end

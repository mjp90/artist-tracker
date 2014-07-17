class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)

    
  end

  def twitter
    omni_auth_request = request.env['omniauth.auth']
    current_user.create_or_update_twitter_oauth(omni_auth_request)

    flash[:notice] = "Successfully Authenticated With Twitter!"
    redirect_to dashboard_show_path
    # session['devise.twitter_uid'] = request.env['omniauth.auth']
  end

end
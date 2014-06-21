class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)

    
  end

  def twitter
    # raise omni = request.env['omniauth.auth'].to_yaml
    omni_auth_request = request.env['omniauth.auth']
    TwitterAccount.find_for_oauth(omni_auth_request)
  end

end
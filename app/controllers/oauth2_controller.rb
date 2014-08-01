class Oauth2Controller < ApplicationController
  def youtube
    binding.pry
    x=1

    api_code = params[:code]
    # API_KEYS['youtube']['code'] = api_code
    # File.open(Rails.root.join('config', 'api_keys.yml'), 'w') {|f| f.write API_KEYS.to_yaml}
    # redirect_to dashboard_
  end
end
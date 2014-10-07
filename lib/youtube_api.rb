require 'google/api_client'
require 'launchy'

class YoutubeApi

  def self.client
    unless @client
      @client = Google::APIClient.new
      @client.discovered_api('youtube', 'v3')
      @client.authorization.client_id = YOUTUBE_API_KEY
      @client.authorization.client_secret = YOUTUBE_API_SECRET
      @client.authorization.scope = 'https://www.googleapis.com/auth/youtube'
      @client.authorization.redirect_uri = "http://localhost:3000/oauth2/youtube"
    end

    @client
  end

  @client ||= begin
    client = Google::APIClient.new(application_name: 'xxx', application_version: '0.0.1')
    client.authorization.client_id = "966069733816-sigqe3mda06spkqce16bnoqbqc3v6r6c.apps.googleusercontent.com"
    client.authorization.client_secret = "SlNQF0AJfnC36PxiB7Lucn0V"
    client.authorization.scope = 'https://www.googleapis.com/auth/youtube'
    client.authorization.grant_type = 'refresh_token'
    client
  end

  "https://accounts.google.com/o/oauth2/auth?code=#{YOUTUBE_API_CODE}&client_id=#{YOUTUBE_API_KEY}&client_secret=#{YOUTUBE_API_SECRET}&redirect_uri=http://localhost:3000/oauth2/youtube&grant_type=authorization_code"

  client = Google::APIClient.new
  client.discovered_api('youtube', 'v3')
  client.authorization.client_id = YOUTUBE_API_KEY
  client.authorization.client_secret = YOUTUBE_API_SECRET
  client.authorization.scope = 'https://www.googleapis.com/auth/youtube'
  client.authorization.redirect_uri = "http://localhost:3000/oauth2/youtube"

  uri = client.authorization.authorization_uri
  Launchy.open(uri)

  client.authorization.code = YOUTUBE_API_CODE
  client.authorization.grant_type = 'authorization_code'
  client.authorization.fetch_access_token!

  client.execute!(:api_method => youtube.channels.list, :parameters)


  ## REFRESH TOKEN
  if client.authorization.expired? do
  data = {
    :client_id => GOOGLE_KEY,
    :client_secret => GOOGLE_SECRET,
    :refresh_token => REFRESH_TOKEN,
    :grant_type => "refresh_token"
  }

  fetch_access_token

  @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
  if @response["access_token"].present?
    #save it
  end




  # Fetch User Channel ID: url = "https://www.googleapis.com/youtube/v3/channels?key=AIzaSyCUqxV-fNgpQZdpF_avB6-vzTgBafnhWwg&forUsername=pandora&part=id"
  # Fetch User Playlist ID = Same as above but contentDetails part has an Upload ID
  # Fetch Video IDs = "https://www.googleapis.com/youtube/v3/playlistItems?key=AIzaSyCUqxV-fNgpQZdpF_avB6-vzTgBafnhWwg&playlistId=UU7KQTDqBbdCJJnuJpx7VNlQ&part=contentDetails&max_results=10"
    ### Each response = ["items"][0]["contentDetails"]["videoId"]
  # Fetch Video URL = "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyCUqxV-fNgpQZdpF_avB6-vzTgBafnhWwg&part=player&id=iV7a073rfBk"
    ### iFrame ["items"][0]["player"]["embedHtml"]
end














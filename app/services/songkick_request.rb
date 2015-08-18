class SongkickRequest
  attr_reader :error

  def initialize(songkick_account:)
    @songkick_account = songkick_account
    @client           = Apis::SongkickApi::SongkickClient.new
    @error            = nil
  end

  def success?
    @error.nil?
  end

  def refresh_artist_account
    request = client.account_information(identifier: songkick_identifier)

    if request.success?
      twitter_account.update!(request.formatted_response)
    else
      @error = request.error
    end
  end

  def refresh_artist_concerts
    request = client.tweets(identifier: twitter_identifier)

    if request.success?
      twitter_account.update_tweets(request.formatted_response)
    else
      @error = request.error
    end
  end

  private
  attr_reader :songkick_account, :client

  def songkick_identifier
    songkick_account.songkick_id || songkick_account.display_name
  end
end

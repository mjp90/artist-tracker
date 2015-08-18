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
    request = client.account_information(identifier: songkick_account.display_name)

    if request.success?
      twitter_account.update!(request.formatted_response)
    else
      @error = request.error
    end
  end

  def refresh_artist_concerts
    request = client.upcoming_concerts(identifier: songkick_account.songkick_uid)

    if request.success?
      songkick_account.update_concerts(request.formatted_response)
    else
      @error = request.error
    end
  end

  private
  attr_reader :songkick_account, :client
end

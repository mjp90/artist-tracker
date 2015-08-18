class TwitterRequest
  attr_reader :error

  def initialize(twitter_account:)
    @twitter_account = twitter_account
    @client          = build_client
    @error           = nil
  end

  def success?
    @error.nil?
  end

  def refresh_artist_account!
    request = client.account_information(identifier: twitter_identifier)

    if request.success?
      twitter_account.update!(request.formatted_response)
    else
      @error = request.error
    end
  end


  def refresh_account!
    request = client.account_information

    if request.success?
      twitter_account.update(request.formatted_response)
    else
      @error = request.error
    end
  end

  def tweet!(text:)
    request = client.tweet(text: text)

    if request.success?
      twitter_account.tweets.create(request.formatted_response)
    else
      @error = request.error
    end
  end

  def retweet!(tweet_uid:)
    request = client.retweet(tweet_uid: tweet_uid)

    if request.success?
      twitter_account.tweets.create(request.formatted_response)
    else
      @error = request.error
    end
  end

  private
  attr_reader :twitter_account, :client

  def build_client
    if twitter_account.user?
      Apis::TwitterApi::UserClient.new(access_token: twitter_account.oauth_token, access_token_secret: twitter_account.oauth_secret)
    else
      Apis::TwitterApi::ApplicationClient.new(access_token: TWITTER_API_ACCESS_TOKEN, access_token_secret: TWITTER_API_ACCESS_TOKEN_SECRET)
    end
  end

  def twitter_identifier
    twitter_account.twitter_uid || twitter_account.username
  end
end

class TwitterController < ApplicationController
  def create_artist_account
    artist          = Artist.find_by(params[:artist_id])
    twitter_account = artist.twitter_account.new(username: params[:username])
    request         = TwitterRequest.new(twitter_account: twitter_account)
    request.refresh_artist_account

    if request.success?
      head :ok
    else
      error = request.error
      render status: error.code, json: { message: error.message, limit: error.limit, reset_in: error.reset_in }
    end
  end

  def refresh_artist_account
    twitter_account = TwitterAccount.find_by(params[:twitter_account_id])
    request         = TwitterRequest.new(twitter_account: twitter_account)
    request.refresh_artist_account

    if request.success?
      head :ok
    else
      error = request.error
      render status: error.code, json: { message: error.message, limit: error.limit, reset_in: error.reset_in }
    end
  end

  def refresh_account
    request = TwitterRequest.new(twitter_account: current_user.twitter_account)
    request.refresh_account!

    if request.success?
      head :ok
    else
      error = request.error
      render status: error.code, json: { message: error.message, limit: error.limit, reset_in: error.reset_in }
    end
  end

  def tweet
    request = TwitterRequest.new(twitter_account: current_user.twitter_account)
    request.tweet!(text: params[:text])

    if request.success?
      head :ok
    else
      error = request.error
      render status: error.code, json: { message: error.message, limit: error.limit, reset_in: error.reset_in }
    end
  end

  def retweet
    request = TwitterRequest.new(twitter_account: current_user.twitter_account)
    request.retweet!(tweet_uid: params[:tweet_uid])

    if request.success?
      head :ok
    else
      error = request.error
      render status: error.code, json: { message: error.message, limit: error.limit, reset_in: error.reset_in }
    end
  end
end

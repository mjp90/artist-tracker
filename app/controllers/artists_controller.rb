class ArtistsController < ApplicationController

  def index
    
  end

  def show
    @artist = current_user.artists.where(:id => params[:id]).take
    head :not_found and return unless @artist

    @artist_twitter_account    = @artist.twitter_account
    @artist_facebook_account   = @artist.facebook_account
    @artist_soundcloud_account = @artist.soundcloud_account

    # @artist_songkick_account   = SongkickAccount.preload(:concerts).where(:account_owner => @artist).take
    @artist_songkick_account   = @artist.songkick_account

    @user_twitter_account = current_user.twitter_account
  end

  def follow
    artist = Artist.find(params[:artist_id])
    current_user.follow(artist)

    render json: { status: :ok, errors: [current_user.errors] }
  end

  def unfollow
    
  end

  def show_twitter_feed
    
  end

  def show_facebook_feed
    
  end

  def show_soundcloud_feed
    
  end

  def show_songkick_feed
    
  end

  def retweet
    tweet = Tweet.find(params[:id])
    TwitterApi.retweet(current_user.twitter_account, tweet)
    flash[:notice] = "Retweeted"
    redirect_to :back
  end

  def favorite_tweet
    tweet = Tweet.find(params[:id])
    TwitterApi.favorite(current_user.twitter_account, tweet)
    redirect_to :back
  end

  def reply_to_tweet
    tweet = Tweet.find(params[:id])
    TwitterApi.reply(current_user.twitter_account, tweet, params[:message]+'@'+tweet.twitter_account.username)
    redirect_to :back
  end
end

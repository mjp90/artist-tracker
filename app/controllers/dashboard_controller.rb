class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to dashboard_show_path
  end

  def show
    @artists = current_user.artists
  end

  def twitter_bench
    twitter_rate_limit = AppTwitterRateLimitStatus.first
    user_timeline_requests_remaining = twitter_rate_limit.remaining_user_timeline_requests
    twitter_account = Artist.first.twitter_account

    if user_timeline_requests_remaining > 0
      TwitterJob.enqueue(twitter_account.id, :update_tweets)
    elsif twitter_rate_limit.user_timeline_reset_time < Time.now
      TwitterApi.check_rate_limit
      TwitterJob.enqueue(twitter_account.id, :update_tweets)
    else
      Rails.log.info "BLOCKED Until #{twitter_rate_limit.user_timeline_reset_time}"
    end

    redirect_to dashboard_show_path
  end

  def test_tweet
    TwitterApi.tweet(current_user.twitter_account)
    redirect_to dashboard_show_path
  end

  def facebook_bench
    Artist.first.facebook_account.update_posts
    redirect_to dashboard_show_path
  end
  
  def songkick_bench
    Artist.first.songkick_account.update_concerts
    redirect_to dashboard_show_path
  end

  def create_temp_artist
    Artist.create!(:name => 'Zedd', :country => 'Germany', :city => 'Kaiserslautern', :music_genre => 'Electro House', :age => '24',
      :twitter_url => "http://twitter.com/zedd", :facebook_url => "http://www.facebook.com/Zedd", :soundcloud_url => "http://soundcloud.com/zedd", 
      :songkick_url => "http://www.songkick.com/artists/992104-zedd")


    redirect_to dashboard_show_path
  end
end

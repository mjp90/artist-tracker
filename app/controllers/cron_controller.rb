class CronController < ApplicationController
  def update_tweets
    logger.info "CRON - TWITTER"
    twitter_account = Artist.first.twitter_account
    TwitterJob.enqueue(twitter_account.id, :update_tweets)

    head :ok
  end
end
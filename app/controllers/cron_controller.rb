class CronController < ApplicationController
  def refresh_artist_twitter_feeds
    logger.info "CRON - TWITTER"

    ArtistFeeds.refresh

    head :ok
  end
end

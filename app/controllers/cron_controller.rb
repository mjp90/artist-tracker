class CronController < ApplicationController
  def refresh_artist_twitter_feeds
    logger.info "CRON - TWITTER"
    Artist.all.each do |artist|
      TwitterJob.enqueue(TwitterFeed, :refresh_for_artist, artist.id)
    end

    head :ok
  end
end

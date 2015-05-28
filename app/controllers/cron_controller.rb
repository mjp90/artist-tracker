class CronController < ApplicationController
  def refresh_artist_twitter_feeds
    logger.info "CRON - TWITTER"

    # TODO: Grab Artists in Order of last updated_at by Twitter Account
    Artist.all.each do |artist|
      TwitterJob.enqueue(TwitterFeed, :refresh_for_artist, artist.id)
    end

    head :ok
  end
end

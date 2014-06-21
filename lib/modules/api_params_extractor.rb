module ApiParamsExtractor
  class Twitter
    def extract_fetched_account_info(fetched_account)
      {
        :twitter_id => fetched_account.id,
        :name => fetched_account.name,
        :screen_name => fetched_account.screen_name,
        :tagline => fetched_account.description,
        :location => fetched_account.location,
        :language => fetched_account.lang,
        :profile_pic_url => fetched_account.profile_background_image_url,
        :join_date => fetched_account.created_at,
        :statuses_count => fetched_account.statuses_count,
        :followers_count => fetched_account.followers_count,
        :friends_count => fetched_account.friends_count,
        :verified => fetched_account.verified? # This is more official
      }
    end

    def extract_tweet_info(tweet)
      {
        :twitter_id => tweet.id,
        # parse tweet.text -> "RT @SurrenderVegas: The only place you'll find @Zedd this #EDC week is @SurrenderVegas this Sat, 6/21!\n\nTickets: http://t.co/atLAua7bNW htt…"
        :is_retweet => # Parse above line to check for RT (true) or if reteweeted status is present (true),
        :original_tweet_id => tweet.reteweeted_status.id, # Nil OK
        :tweeted_from_location => fa.status.retweeted_status.place.full_name, # "Paradise, NV"
        :reteweet_count => fa.status.retweeted_status.reteweet_count,
        :favorite_count => fa.status.retweeted_status.favorite_count,
        :hash_tags << fa.status.retweeted_status.hashtags.map(&:text),
        :urls << fa.status.retweeted_status.urls.map(&:expanded_url),
        : << fa.status.retweeted_status.user_mentions.map(&:screen_name),
        # : << media.map(&:url) - Detail Screen of Tweet - Could use iFrame to save effort but may not work
        # media.map(&:media_url) - Actual Image URL for each assest in tweet
      }
    end
  end

  class Facebook

  end

  class Soundcloud

  end

  class Songkick

  end
end
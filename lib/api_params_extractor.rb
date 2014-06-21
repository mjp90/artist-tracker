module ApiParamsExtractor
  class Twitter
    def extract_fetched_account_info(fetched_account)
      {
        :username => fetched_account.name,
        :screen_name => fetched_account.screen_name,
        :tagline => fetched_account.description,
        :location => fetched_account.location,
        :language => fetched_account.lang,
        :profile_pic_url => fetched_account.profile_background_image_url,
        :join_date => fetched_account.created_at,
        :statuses_count => fetched_account.statuses_count,
        :followers_count => fetched_account.followers_count
      }
    end

    def extract_tweet_info(tweet)
      {
        
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
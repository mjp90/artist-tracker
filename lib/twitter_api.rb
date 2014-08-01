class TwitterApi

  def self.client(access_token=nil, access_token_secret=nil)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = TWITTER_API_KEY
      config.consumer_secret = TWITTER_API_SECRET
      config.access_token = access_token || TWITTER_API_ACCESS_TOKEN
      config.access_token_secret = access_token_secret || TWITTER_API_ACCESS_TOKEN_SECRET
    end
  end

  def self.get_account_info_for_owner(owner)
    username = owner.twitter_url
    username.slice!(/.*com\//)
    
    begin
      response     = client.user(username) #Can Raise Twitter::Error::TooManyRequests
    rescue Twitter::Error::TooManyRequests => e
      check_rate_limit
    end

    account_info = self.extract_account_info(response)

    # How to fill in Artist URLs not found yet
    # other_api_accounts = self.extract_other_api_account_urls(response)
  end

  def self.tweets_for_account(account, options=nil)
    options ||= {:count => 150, :exclude_replies => true}
    begin
      response = client.user_timeline(account.twitter_id.to_i, options)
    rescue Twitter::Error::TooManyRequests => e
      check_rate_limit
      raise "Request Limit Hit"
    end

    tweets   = []
    response.each do |tweet|
      tweets.prepend(self.extract_tweet_info(tweet))
    end

    tweets
  end


  # Reply to a Tweet
  # client.update("Test API Tweet!", :in_reply_to_status_id => )

  # Retweet. Pass ID. :trim_user makes it so you don't get all the unecessary tweet data? NOT RATE LIMITED 
  # client.retweet([id], :trim_user => true)

  # Follow User. NOT RATE LIMITED 
  # friendships/create => https://dev.twitter.com/docs/api/1.1/post/friendships/create
  # friendships/destroy

  # Favorite a Tweet. NOT RATE LIMITED 
  # favorites/create :include_entities => false => https://dev.twitter.com/docs/api/1.1/post/favorites/create


  def self.tweet(account)
    client(account.oauth_token, account.oauth_secret).update("Tearin it ^")
  end

  def self.retweet(account, tweet)
    client(account.oauth_token, account.oauth_secret).retweet(tweet.twitter_id, :trim_user => true)
  end

  def self.favorite(account, tweet)
    client(account.oauth_token, account.oauth_secret).favorite(tweet.twitter_id, :include_entities => false)
  end

  # Message must contain "@username" repsonding to
  # https://dev.twitter.com/docs/api/1/post/statuses/update
  def self.reply(account, tweet, message)
    client(account.oauth_token, account.oauth_secret).update(message, :in_reply_to_status_id => tweet.id, :trim_user => true)
  end

  def self.follow(account, artist)
    client(account.oauth_token, account.oauth_secret).friendship_create(artist.twitter_id, :include_entities => false)
  end

  def self.check_rate_limit
    response            = client.get('/1.1/application/rate_limit_status.json')[:body]
    user_methods        = response[:resources][:users]
    status_methods      = response[:resources][:statuses]
    application_methods = response[:resources][:application]
    application_rate_limit, user_show, status_user_timeline = {}, {}, {}

    binding.pry
    user_show[:remaining_user_info_requests]                = user_methods[:"/users/show/:id"][:remaining]
    user_show[:user_info_reset_time]                        = Time.at(user_methods[:"/users/show/:id"][:reset])
    status_user_timeline[:remaining_user_timeline_requests] = status_methods[:"/statuses/user_timeline"][:remaining]
    status_user_timeline[:user_timeline_reset_time]         = Time.at(status_methods[:"/statuses/user_timeline"][:reset])
    application_rate_limit[:remaining_rate_limit_requests]  = application_methods[:"/application/rate_limit_status"][:remaining]
    application_rate_limit[:rate_limit_reset_time]          = Time.at(application_methods[:"/application/rate_limit_status"][:reset])

    user_show.merge!(status_user_timeline).merge!(application_rate_limit)

    app_rate_limit_status = AppTwitterRateLimitStatus.where(:id => 1).first
    app_rate_limit_status.present? ? app_rate_limit_status.update_attributes(user_show) : AppTwitterRateLimitStatus.create(user_show)
  end

  def self.extract_account_info(response)
    {
      :followers_count              => response.followers_count,
      :friends_count                => response.friends_count,
      :join_date                    => response.created_at,
      :language                     => response.lang,
      :location                     => response.location,
      :profile_background_color     => response.profile_background_color,
      :profile_background_image_url => response.profile_background_image_url,
      :profile_banner_url           => response.profile_banner_url.to_s,
      :profile_pic_url              => response.profile_image_url.to_s,
      :statuses_count               => response.statuses_count,
      :tagline                      => response.description,
      :twitter_id                   => response.id,
      :username                     => response.screen_name
    }
  end

  def self.extract_tweet_info(tweet)
    favorites_count = tweet.retweet? ? tweet.retweeted_status.favorite_count : tweet.favorite_count
    {
      :attachment_url         => tweet.media.first.try(:media_url).to_s,
      :favorites_count        => favorites_count,
      :hashtags               => tweet.retweet? ? (tweet.hashtags - tweet.retweeted_status.hashtags).map{|ht| ht.text} : tweet.hashtags.map{|ht| ht.text},
      :is_retweet             => tweet.retweet?,
      :message                => tweet.text.encode("iso-8859-1", undef: :replace, replace: ''),
      :retweet_attachment_url => (tweet.retweeted_status.media.first.try(:media_url).to_s if tweet.retweet?),
      :retweet_count          => tweet.retweet_count,
      :retweet_hashtags       => (tweet.retweeted_status.hashtags.map{|ht| ht.text} if tweet.retweet?),
      :retweet_user_mentions  => (tweet.retweeted_status.user_mentions.map{|um| um.screen_name} if tweet.retweet?),
      :tweeted_at             => tweet.created_at, # 2014-06-28 20:41:38 -0700 
      :twitter_id             => tweet.id.to_s,
      :user_mentions          => (tweet.retweet? ? (tweet.user_mentions - tweet.retweeted_status.user_mentions).map{|um| um.screen_name} : tweet.user_mentions.map{|um| um.screen_name})
    }
  end

  def self.extract_other_api_account_urls(response)
    urls = response.website_uris
    urls.each do |url|
      case url.expanded_url.host
      when 'facebook.com'
        # Update Artist Facebook URL if Not Present -> Artist.update_attributes(:twitter_url => url.to_s)
      end
    end
  end

end
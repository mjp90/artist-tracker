module TwitterApi
  class Methods

    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key    = TWITTER_API_KEY
        config.consumer_secret = TWITTER_API_SECRET
        config.access_token = "2556622700-25CiVZIdJJZCDWbxqZhq2AHjGx1a4W0axCoD7U7"
        config.access_token_secret = "5flzwd9Xgc0HugEKqPx8KYhnNTCUQhQ7CtStaB9Ac0IP1"
      end
    end

    # Returns a Twitter::User object
    def self.get_account_for_username(username)
      client.user(username)
    end

    def self.tweets_for_account(account, min_id=nil)
      # options[:max_id] => min_id if min_id
      options = {:count => 50}
      client.user_timeline(account.id, options)
    end
  end

end
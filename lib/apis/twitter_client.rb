module Apis
  class TwitterClient
    attr_reader :client

    def initialize
      raise "Implement in subclass!"
    end

    def account_information
      raise "Implement in subclass!"
    end
    alias_method :account_info, :account_information

    def tweets
      raise "Implement in subclass!"
    end

    def favorite
      
    end

    def unfavorite
      
    end

    def follow
      
    end

    def unfollow
      
    end

    def friends_with_user?(target_uid:, options:)
      
    end

    def update_status(status_text:, options:)
      
    end

    def retweet(tweet_uid:, options:)
      
    end

    private
    attr_reader :access_token, :access_token_secret
    
    def build_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = TWITTER_API_KEY
        config.consumer_secret     = TWITTER_API_SECRET
        config.access_token        = access_token
        config.access_token_secret = access_token_secret
      end  
    end
  end
end

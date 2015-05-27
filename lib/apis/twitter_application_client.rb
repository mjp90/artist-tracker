module Apis
  class TwitterApplicationClient < Apis::TwitterClient
    def initialize
      @access_token        = TWITTER_API_ACCESS_TOKEN
      @access_token_secret = TWITTER_API_ACCESS_TOKEN_SECRET
      @client              = build_client
    end

    def account_information(uid:)
      client.user(uid)
    rescue Twitter::Error::TooManyRequests => e
      # Handle Error
    end
    alias_method :account_info, :account_information

    def tweets(uid:, options:)
      options ||= { count: 100, exclude_replies: true }

      client.user_timeline(uid, options)
    rescue Twitter::Error::TooManyRequests => e
      # Handle Error
    end
  end
end

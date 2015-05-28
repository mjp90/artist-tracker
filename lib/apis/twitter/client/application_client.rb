module Apis
  module Twitter
    class Client::ApplicationClient < Apis::Twitter::Client::GenericClient
      attr_reader :client

      def initialize
        @access_token        = TWITTER_API_ACCESS_TOKEN
        @access_token_secret = TWITTER_API_ACCESS_TOKEN_SECRET
        @client              = build_client
      end

      def account_information(uid:)
        client.user(uid)
      rescue ::Twitter::Error::TooManyRequests => e
        Apis::Twitter::Client::RequestError.new(e)
        # Handle Error
        # e.rate_limit returns a RateLimit Object
        # Mail Message { code: e.code, message: e.message, max_limit: e.rate_limit.limit, remaining: e.rate_limit.remaining, reset_at: e.rate_limit.reset_at (DateTime), reset_in: e.rate_limit.reset_in (Seconds until can reset) }
      end
      alias_method :account_info, :account_information

      def tweets(uid:, options:)
        options ||= { count: 100, exclude_replies: true }

        client.user_timeline(uid, options)
      rescue ::Twitter::Error::TooManyRequests => e
        Apis::Twitter::Client::RequestError.new(e)
      end

      private
      attr_reader :client, :access_token, :access_token_secret
      
    end
  end
end

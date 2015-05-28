module Apis
  module Twitter
    class Client::UserClient < Apis::Twitter::Client::GenericClient
      def initialize(access_token:, access_token_secret:)
        @access_token        = access_token
        @access_token_secret = access_token_secret
        @client              = build_client
      end

      def account_information
        client.user
      rescue Twitter::Error::TooManyRequests => e
        # Handle Error
      end
      alias_method :account_info, :account_information

      def tweets(options:)
        
      end

      private
      attr_reader :client, :access_token, :access_token_secret
    end
  end
end

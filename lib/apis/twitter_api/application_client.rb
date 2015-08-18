module Apis
  module TwitterApi
    class ApplicationClient
      include TwitterClient

      def initialize(access_token:, access_token_secret:)
        @client = build_client(access_token: access_token, access_token_secret: access_token_secret)
        @error  = nil
        @formatted_response = nil
      end

      def account_information(identifier:)
        request = Request.new(
          client: client,
          request_name: :user,
          response_formatter: Twitter::Response::Account,
          arg: identifier
        )
        request.send

        request
      end

      def tweets(user_uid:, options: nil)
        options ||= { count: 100, exclude_replies: true }
        request = Request.new(
          client: client,
          request_name: :user_timeline,
          response_formatter: Twitter::Response::Tweets,
          arg: user_uid,
          options: options
        )
        request.send

        request
      end

      private
      attr_reader :client, :error, :formatted_response

    end
  end
end

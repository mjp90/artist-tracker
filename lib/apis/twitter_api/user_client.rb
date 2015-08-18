module Apis
  module TwitterApi
    class UserClient
      include TwitterClient

      def initialize(access_token:, access_token_secret:)
        @client = build_client(access_token: access_token, access_token_secret: access_token_secret)
        @error  = nil
        @formatted_response = nil
      end

      def account_information
        request = Request.new(
          client: client,
          request_name: :user,
          response_formatter: Twitter::Response::Account
        )
        request.send

        request
      end

      def favorite(tweet_uid:)
        request = Request.new(
          client: client,
          request_name: :favorite,
          response_formatter: Twitter::Response::Tweets,
          arg: tweet_uid
        )
        request.send

        request
      end

      def unfavorite(tweet_uid:)
        request = Request.new(
          client: client,
          request_name: :unfavorite,
          response_formatter: Twitter::Response::Tweets,
          arg: tweet_uid
        )
        request.send

        request
      end

      def follow(user_uid:)
        request = Request.new(
          client: client,
          request_name: :follow,
          response_formatter: Twitter::Response::Account,
          arg: user_uid
        )
        request.send

        request
      end

      def unfollow(user_uid:)
        request = Request.new(
          client: client,
          request_name: :unfollow,
          response_formatter: Twitter::Response::Account,
          arg: user_uid
        )
        request.send

        request
      end

      def friendship?(target_uid:)
        request = Request.new(
          client: client,
          request_name: :friendship?,
          response_formatter: Twitter::Response::Bool,
          arg: target_uid
        )
        request.send

        request
      end

      def tweet(text:)
        request = Request.new(
          client: client,
          request_name: :update,
          response_formatter: Twitter::Response::Tweet,
          arg: text
        )
        request.send

        request
      end

      def retweet(tweet_uid:)
        request = Request.new(
          client: client,
          request_name: :retweet,
          response_formatter: Twitter::Response::Tweets,
          arg: tweet_uid
        )
        request.send

        request
      end

      private
      attr_reader :client, :error, :formatted_response
    end
  end
end

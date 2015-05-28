module Apis
  module Twitter
    class Client::GenericClient
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
        client(account.oauth_token, account.oauth_secret).favorite(tweet.twitter_id, :include_entities => false)
      end

      def unfavorite
        
      end

      def follow
        client(account.oauth_token, account.oauth_secret).friendship_create(artist.twitter_id, :include_entities => false)
      end

      def unfollow
        
      end

      def reply
        client(account.oauth_token, account.oauth_secret).update(message, :in_reply_to_status_id => tweet.id, :trim_user => true)
      end

      def friends_with_user?(target_uid:, options:)
        
      end

      def update_status(status_text:, options:)
        
      end

      def tweet
        client(account.oauth_token, account.oauth_secret).update("Tearin it ^")
      end

      def retweet(tweet_uid:, options:)
        client(account.oauth_token, account.oauth_secret).retweet(tweet.twitter_id, :trim_user => true)
      end

      def rate_limit_status
        response            = client.get('/1.1/application/rate_limit_status.json')[:body]
        user_methods        = response[:resources][:users]
        status_methods      = response[:resources][:statuses]
        application_methods = response[:resources][:application]
        application_rate_limit, user_show, status_user_timeline = {}, {}, {}

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

      def self.extract_other_api_account_urls(response)
        urls = response.website_uris
        urls.each do |url|
          case url.expanded_url.host
          when 'facebook.com'
            # Update Artist Facebook URL if Not Present -> Artist.update_attributes(:twitter_url => url.to_s)
          end
        end
      end

      private
      attr_reader :access_token, :access_token_secret
      
      def build_client
        ::Twitter::REST::Client.new do |config|
          config.consumer_key        = TWITTER_API_KEY
          config.consumer_secret     = TWITTER_API_SECRET
          config.access_token        = access_token
          config.access_token_secret = access_token_secret
        end
      end
    end
  end
end

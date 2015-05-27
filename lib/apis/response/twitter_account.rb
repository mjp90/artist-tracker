module Apis
  module Response
    class TwitterAccount
      def initialize(account_response:)
        @account_response = account_response
      end

      def serialize
        {
          :followers_count              => account_response.followers_count,
          :friends_count                => account_response.friends_count,
          :join_date                    => account_response.created_at,
          :language                     => account_response.lang,
          :location                     => account_response.location,
          :profile_background_color     => account_response.profile_background_color,
          :profile_background_image_url => account_response.profile_background_image_url,
          :profile_banner_url           => account_response.profile_banner_url.to_s,
          :profile_pic_url              => account_response.profile_image_url.to_s,
          :statuses_count               => account_response.statuses_count,
          :tagline                      => account_response.description,
          :twitter_id                   => account_response.id,
          :username                     => account_response.screen_name
        }
      end

      private
      attr_reader :account_response
    end
  end
end

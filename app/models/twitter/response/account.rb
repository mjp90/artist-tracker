module Twitter
  module Response
    class Account
      def initialize(response:)
        @response = response
      end

      def serialize
        {
          display_name:                 response.name,
          followers_count:              response.followers_count,
          friends_count:                response.friends_count,
          join_date:                    response.created_at,
          language:                     response.lang,
          location:                     response.location,
          profile_background_color:     response.profile_background_color,
          profile_background_image_url: response.profile_background_image_url,
          profile_banner_url:           response.profile_banner_url.to_s,
          profile_pic_url:              response.profile_image_url.to_s,
          profile_link_color:           response.profile_link_color,
          profile_use_background_image: response.profile_use_background_image?,
          status:                       response.status.try(:text),
          statuses_count:               response.statuses_count,
          tagline:                      response.description,
          time_zone:                    response.time_zone,
          twitter_uid:                  response.id.to_s,
          url:                          response.url.to_s,
          username:                     response.screen_name,
          verified:                     response.verified?
        }
      end

      private
      attr_reader :response
    end
  end
end

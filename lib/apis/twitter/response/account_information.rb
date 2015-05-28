module Apis
  module Twitter
    class Response::AccountInformation
      def initialize(response:)
        @response = response.with_indifferent_access
      end

      def serialize
        {
          display_name:                 response.fetch(:name, nil),
          followers_count:              response.fetch(:followers_count, nil),
          friends_count:                response.fetch(:friends_count, nil),
          join_date:                    response.fetch(:created_at, nil),
          language:                     response.fetch(:lang, nil),
          location:                     response.fetch(:location, nil),
          profile_background_color:     response.fetch(:profile_background_color, nil),
          profile_background_image_url: response.fetch(:profile_background_image_url, nil),
          profile_banner_url:           response.fetch(:profile_banner_url.to_s, nil),
          profile_pic_url:              response.fetch(:profile_image_url.to_s, nil),
          profile_link_color:           response.fetch(:profile_link_color, nil),
          profile_use_background_image: response.fetch(:profile_use_background_image, nil),
          status:                       response.fetch(:status, nil).fetch(:text, nil),
          statuses_count:               response.fetch(:statuses_count, nil),
          tagline:                      response.fetch(:description, nil),
          time_zone:                    response.fetch(:time_zone, nil),
          twitter_id:                   response.fetch(:twitter_id, nil).to_s,
          url:                          response.fetch(:url, nil).to_s,
          username:                     response.fetch(:screen_name, nil),
          verified:                     response.fetch(:verified, nil)
        }
      end

      private
      attr_reader :response
    end
  end
end

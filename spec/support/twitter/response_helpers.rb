module RSpec
  module Support
    module Twitter
      module ResponseHelpers
        def account_response
          status =  double('status', text: 'Twitter Status')
          double('Twitter::Account',
            name: 'Twitter Man',
            followers_count: 1,
            friends_count: 1,
            created_at: DateTime.new,
            lang: 'en',
            location: 'US',
            profile_background_color: 'ffffff',
            profile_background_image_url: 'http://backgroundimage.com',
            profile_banner_url: 'http://banner.com',
            profile_image_url: 'http://linkcolor.com',
            profile_link_color: 'ffffff',
            profile_use_background_image?: true,
            status: status,
            statuses_count: 5,
            description: 'I am Twitter Man.',
            time_zone: 'PDT',
            id: 1,
            url: 'http://foo.com',
            screen_name: 'tman1',
            verified?: true
          )
        end

        def tweet_response
          double("MockTweet",
            attachment_url: "http://attachment.com",
            favorites_count: 2,
            hashtags: ["#hashtag"],
            retweet?: false,
            language: "en",
            message: "Tweet Message",
            retweet_attachment_url: nil,
            retweet_count: 2,
            retweet_hashtags: "",
            retweet_user_mentions: "",
            truncated?: false,
            tweeted_at: DateTime.new,
            twitter_uid: "1",
            user_mentions: ""
          )
        end

        def mock_tweet
          {
            attachment_url: "http://attachment.com",
            favorites_count: 2,
            hashtags: ["#hashtag"],
            retweet?: false,
            language: "en",
            message: "Tweet Message",
            retweet_attachment_url: nil,
            retweet_count: 2,
            retweet_hashtags: "",
            retweet_user_mentions: "",
            truncated?: false,
            tweeted_at: DateTime.new,
            twitter_uid: "1",
            user_mentions: ""
          }
        end

        def error_response
          rate_limit = double("RateLimit",
            limit: 180,
            remaining: 0,
            reset_at: 120,
            reset_in: 60
          )
          double("Twitter::Error",
            code: 400,
            message: "error",
            rate_limit: rate_limit
          )
        end
      end
    end
  end
end

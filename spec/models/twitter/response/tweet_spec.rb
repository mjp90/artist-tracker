require "rails_helper"
require "support/twitter/response_helpers"

RSpec.describe Twitter::Response::Tweet, type: :model do
  include RSpec::Support::Twitter::ResponseHelpers

  let(:formatted_response) { Twitter::Response::Tweet.new(response: tweet_response).serialize }

  describe "#serialize" do
    it "returns a parsed hash of TwitterAccount attributes" do
      allow_any_instance_of(Twitter::Response::Tweet).to receive(:build_mock_tweet) { tweet_response }

      expect(formatted_response[:attachment_url]).to eq tweet_response.attachment_url
      expect(formatted_response[:favorites_count]).to eq tweet_response.favorites_count
      expect(formatted_response[:hashtags]).to eq tweet_response.hashtags
      expect(formatted_response[:is_retweet]).to eq tweet_response.retweet?
      expect(formatted_response[:language]).to eq tweet_response.language
      expect(formatted_response[:message]).to eq tweet_response.message
      expect(formatted_response[:retweet_attachment_url]).to eq tweet_response.retweet_attachment_url
      expect(formatted_response[:retweet_count]).to eq tweet_response.retweet_count
      expect(formatted_response[:retweet_hashtags]).to eq tweet_response.retweet_hashtags
      expect(formatted_response[:retweet_user_mentions]).to eq tweet_response.retweet_user_mentions
      expect(formatted_response[:truncated]).to eq tweet_response.truncated?
      expect(formatted_response[:tweeted_at]).to eq tweet_response.tweeted_at
      expect(formatted_response[:twitter_uid]).to eq tweet_response.twitter_uid
      expect(formatted_response[:user_mentions]).to eq tweet_response.user_mentions
    end
  end
end

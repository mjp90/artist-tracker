require "rails_helper"

describe Apis::Twitter::Response::Tweet do
  let(:formatted_response) { Apis::Twitter::Response::Tweet.new(response: mock_tweet).serialize }
  let(:mock_tweet) do
    double("MockTweet",
      attachment_url: "http://attachment.com",
      favorite_count: 2,
      hashtags: ["#hashtag"],
      retweet?: false,
      language: "en",
      message: "Tweet Message",
      retweet_attachment_url: nil,
      retweet_count: 2, 
      retweet_hashtags: "",
      retweet_user_mentions: "",
      truncated?: false,
      tweeted_at: DateTime.now,
      twitter_uid: "1",
      user_mentions: ""
    )
  end

  describe "#serialize" do
    it "returns a parsed hash of TwitterAccount attributes" do
      allow_any_instance_of(Apis::Twitter::Response::Tweet).to receive(:build_mock_tweet) { mock_tweet }

      request = Apis::Twitter::Response::Tweet.new(response: nil)
      formatted_response = request.serialize

      expect(formatted_response[:attachment_url]).to eq mock_tweet.attachment_url
      expect(formatted_response[:favorites_count]).to eq mock_tweet.favorite_count
      expect(formatted_response[:hashtags]).to eq mock_tweet.hashtags
      expect(formatted_response[:is_retweet]).to eq mock_tweet.retweet?
      expect(formatted_response[:language]).to eq mock_tweet.language
      expect(formatted_response[:message]).to eq mock_tweet.message
      expect(formatted_response[:retweet_attachment_url]).to eq mock_tweet.retweet_attachment_url
      expect(formatted_response[:retweet_count]).to eq mock_tweet.retweet_count
      expect(formatted_response[:retweet_hashtags]).to eq mock_tweet.retweet_hashtags
      expect(formatted_response[:retweet_user_mentions]).to eq mock_tweet.retweet_user_mentions
      expect(formatted_response[:truncated]).to eq mock_tweet.truncated?
      expect(formatted_response[:tweeted_at]).to eq mock_tweet.tweeted_at
      expect(formatted_response[:twitter_uid]).to eq mock_tweet.twitter_uid
      expect(formatted_response[:user_mentions]).to eq mock_tweet.user_mentions
    end
  end
end

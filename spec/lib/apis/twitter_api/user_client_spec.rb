require "rails_helper"

RSpec.describe Apis::TwitterApi::UserClient do
  let(:user_client) do
    Apis::TwitterApi::UserClient.new(
      access_token: '123-456',
      access_token_secret: '456-7890'
    )
  end

  let(:request_mock) do
    Apis::TwitterApi::Request.new(
      client: user_client,
      request_name: :request_name,
      response_formatter: double("Twitter::Response::Formatter"),
      arg: "arg"
    )
  end

  describe "#account_information" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.account_information

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#favorite" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.favorite(tweet_uid: 1)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#unfavorite" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.unfavorite(tweet_uid: 1)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#follow" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.follow(user_uid: 1)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#unfollow" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.unfollow(user_uid: 1)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#friendship?" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.friendship?(target_uid: 1)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#tweet" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.tweet(text: 'Tweet')

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  describe "#retweet" do
    it "returns the response" do
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request_mock }

      response = user_client.retweet(tweet_uid: 1)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end
end

require "rails_helper"

RSpec.describe Apis::TwitterApi::ApplicationClient do
  let(:client) do
    Apis::TwitterApi::ApplicationClient.new(
      access_token: TWITTER_API_ACCESS_TOKEN,
      access_token_secret: TWITTER_API_ACCESS_TOKEN_SECRET
    )
  end

  describe "#account_information" do
    it "returns the response" do
      # expect(Apis::TwitterApi::Request).to receive(:new).with(
      #   client: client,
      #   request_name: :user,
      #   response_formatter: response_formatter
      # )
      response_formatter = Twitter::Response::Account
      request = Apis::TwitterApi::Request.new(
        client: client,
        request_name: :user,
        response_formatter: response_formatter
      )
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request }

      response = client.account_information(identifier: 123)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end

  xdescribe "#tweets" do
    it "returns the response" do
      response_formatter = Twitter::Response::Tweets
      request = Apis::TwitterApi::Request.new(
        client: client,
        request_name: :user_timeline,
        response_formatter: response_formatter,
        arg: 123
      )
      options = { count: 100, exclude_replies: true }
      # allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send).with(options) { request }
      allow_any_instance_of(Apis::TwitterApi::Request).to receive(:send) { request }
      expect(Apis::TwitterApi::Request).to receive(:send).with(options) { request }

      response = client.tweets(user_uid: 123)

      expect(response).to be_instance_of(Apis::TwitterApi::Request)
    end
  end
end

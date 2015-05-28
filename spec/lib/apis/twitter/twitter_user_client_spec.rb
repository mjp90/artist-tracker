require "rails_helper"

describe Apis::Twitter::Client::UserClient do
  let(:user) { create(:user) }
  let(:twitter_account) { double("TwitterAccount", oauth_token: "123-4567", oauth_token_secret: "765-4321") }

  it "client is using the application specific access tokens" do
    allow(user).to receive(:twitter_account) { twitter_account }

    twitter_client = Apis::Twitter::Client::UserClient.new(
      access_token:        user.twitter_account.oauth_token,
      access_token_secret: user.twitter_account.oauth_token_secret
    )

    expect(twitter_client.client.access_token).to eq("123-4567")
    expect(twitter_client.client.access_token_secret).to eq("765-4321")
  end
end

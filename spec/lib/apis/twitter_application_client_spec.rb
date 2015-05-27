require "rails_helper"

describe Apis::TwitterApplicationClient do
  it "client is using the application specific access tokens" do
    twitter_client = Apis::TwitterApplicationClient.new

    expect(twitter_client.client.access_token).to eq(TWITTER_API_ACCESS_TOKEN)
    expect(twitter_client.client.access_token_secret).to eq(TWITTER_API_ACCESS_TOKEN_SECRET)
  end
end

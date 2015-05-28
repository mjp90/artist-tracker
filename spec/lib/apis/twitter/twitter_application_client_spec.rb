require "rails_helper"

xdescribe Apis::Twitter::Client::ApplicationClient do
  it "client is using the application specific access tokens" do
    MASTER_LIST_PATH = Rails.root.join('spec', 'support', 'lib' 'master_list.yml')
    YAML.load_file()

    twitter_client = Apis::Twitter::Client::ApplicationClient.new

    expect(twitter_client.client.access_token).to eq(TWITTER_API_ACCESS_TOKEN)
    expect(twitter_client.client.access_token_secret).to eq(TWITTER_API_ACCESS_TOKEN_SECRET)
  end
end

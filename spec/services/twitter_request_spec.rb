require "rails_helper"
require "support/twitter/response_helpers"

RSpec.describe TwitterRequest do
  include RSpec::Support::Twitter::ResponseHelpers

  let(:twitter_account) { create(:twitter_account, twitter_uid: '1') }
  let(:twitter_request) { TwitterRequest.new(twitter_account: twitter_account) }

  let(:twitter_error_response) do
    double("Apis::TwitterApi::Request", success?: false, formatted_response: nil, error: request_error)
  end

  let(:twitter_tweet_response) do
    double("Apis::TwitterApi::Request", success?: true, formatted_response: formatted_tweet_response)
  end

  let(:twitter_account_response) do
    double("Apis::TwitterApi::Request", success?: true, formatted_response: formatted_account_response)
  end
  let(:formatted_account_response) { Twitter::Response::Account.new(response: account_response).serialize }
  let(:formatted_tweet_response) { mock_tweet }
  let(:request_error) { Twitter::RequestError.new(error_response: error_response) }

  describe "#success" do

  end

  context "Artist Requests" do
    describe "#refresh_artist_account!" do
      it "fetches an artist's account information and updates the account" do
        allow_any_instance_of(Apis::TwitterApi::ApplicationClient).to receive(:account_information) { twitter_account_response }

        twitter_request.refresh_artist_account!

        expect(twitter_account.persisted?).to be true
        expect(twitter_account).to have_attributes(twitter_account_response.formatted_response)
      end
    end
  end

  context "User Requests" do
    before { allow(twitter_account).to receive(:user?) { true } }
    describe "#refresh_account!" do
      it "fetches an user's account information and updates the account" do
        allow_any_instance_of(Apis::TwitterApi::UserClient).to receive(:account_information) { twitter_account_response }

        twitter_request.refresh_account!

        expect(twitter_account).to have_attributes(twitter_account_response.formatted_response)
      end
    end

    describe "#tweet!" do
      before do
        allow_any_instance_of(Apis::TwitterApi::UserClient).to receive(:tweet) { twitter_tweet_response }
      end
      it "creates a tweet on behalf of the user and creates a new tweet record" do
        twitter_request.tweet!(text: "Tweet")

        expect { twitter_account.tweets }.to change(:count).by 1
        # expect(twitter_account).to have_attributes(twitter_account_response.formatted_response)
      end
    end

    describe "#retweet!" do

    end

    describe "#favorite!" do

    end

    describe "#unfavorite!" do

    end

    describe "#follow!" do

    end

    describe "#unfollow!" do

    end
  end

  describe "when an error occurs" do
    it "it returns a RequestError" do
      allow_any_instance_of(Apis::TwitterApi::ApplicationClient).to receive(:account_information) { twitter_error_response }

      twitter_request.refresh_artist_account!

      expect(twitter_request.error).to be_present
      expect(twitter_request.error.class).to be(Twitter::RequestError)
    end
  end
end

require "rails_helper"
require "support/twitter/response_helpers"

RSpec.describe Twitter::Response::Account, type: :model do
  include RSpec::Support::Twitter::ResponseHelpers

  let(:formatted_response) { Twitter::Response::Account.new(response: account_response).serialize }

  describe "#serialize" do
    it "returns a parsed hash of TwitterAccount attributes" do
      expect(formatted_response[:display_name]).to eq('Twitter Man')
      expect(formatted_response[:followers_count]).to eq(1)
      expect(formatted_response[:friends_count]).to eq(1)
      expect(formatted_response[:join_date]).to eq(DateTime.new)
      expect(formatted_response[:language]).to eq('en')
      expect(formatted_response[:location]).to eq('US')
      expect(formatted_response[:profile_background_color]).to eq('ffffff')
      expect(formatted_response[:profile_background_image_url]).to eq('http://backgroundimage.com')
      expect(formatted_response[:profile_banner_url]).to eq('http://banner.com')
      expect(formatted_response[:profile_pic_url]).to eq('http://linkcolor.com')
      expect(formatted_response[:profile_link_color]).to eq('ffffff')
      expect(formatted_response[:profile_use_background_image]).to be true
      expect(formatted_response[:status]).to eq('Twitter Status')
      expect(formatted_response[:statuses_count]).to eq(5)
      expect(formatted_response[:tagline]).to eq('I am Twitter Man.')
      expect(formatted_response[:time_zone]).to eq('PDT')
      expect(formatted_response[:twitter_uid]).to eq('1')
      expect(formatted_response[:url]).to eq('http://foo.com')
      expect(formatted_response[:username]).to eq('tman1')
      expect(formatted_response[:verified]).to be true
    end
  end
end

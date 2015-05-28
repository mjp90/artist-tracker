require "rails_helper"

describe Apis::Twitter::Response::AccountInformation do
  PATH = Rails.root.join('spec', 'support', 'twitter', 'account_information_response.yml')
  let(:formatted_response) { Apis::Twitter::Response::AccountInformation.new(response: YAML.load_file(PATH)).serialize }

  describe "#serialize" do
    it "returns a parsed hash of TwitterAccount attributes" do
      expect(formatted_response[:display_name]).to eq('Twitter Man')
      expect(formatted_response[:status]).to eq('Twitter Status')
      expect(formatted_response[:statuses_count]).to eq(5)
      expect(formatted_response[:twitter_id]).to eq('1')
      expect(formatted_response[:url]).to eq('http://foo.com')
    end

    it "handles nil response attributes" do
      expect(formatted_response[:username]).to be_nil
    end
  end
end

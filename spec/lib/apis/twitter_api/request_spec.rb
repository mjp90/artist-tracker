require "rails_helper"

RSpec.describe Apis::TwitterApi::Request do
  let(:client) { double("Twitter::REST::Client") }
  let(:response_formatter) { double("Twitter::Response::Account") }

  let(:request) do
    Apis::TwitterApi::Request.new(
      client: client,
      request_name: :user,
      response_formatter: response_formatter
    )
  end

  describe "a successful request" do
    before do
      allow(client).to receive(:send) { true }
      allow(response_formatter).to receive(:new) { response_formatter }
      allow(response_formatter).to receive(:serialize) { { key: "value" } }
      request.send
    end
    it "should be a success" do
      expect(request.success?).to be true
    end

    it "should return the formatted response" do
      expect(request.formatted_response).to be_present
    end
  end

  describe "an unsuccessful request" do
    before do
      allow(client).to receive(:send).and_raise(Twitter::Error::TooManyRequests)
      allow(Twitter::RequestError).to receive(:new) { double("Twitter::RequestError") }
      request.send
    end

    it "should be a success" do
      expect(request.success?).to be false
    end

    it "should return the formatted response" do
      expect(request.formatted_response).to be_nil
    end
  end
end

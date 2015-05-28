require "rails_helper"

describe Apis::Twitter::Client::GenericClient do
  it "raises an 'Implement in subclass!' exception when directly instantiated" do
    expect { Apis::Twitter::Client::GenericClient.new }.to raise_error("Implement in subclass!")
  end
end

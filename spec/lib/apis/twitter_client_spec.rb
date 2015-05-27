require "rails_helper"

describe Apis::TwitterClient do
  it "raises an 'Implement in subclass!' exception when directly instantiated" do
    expect { Apis::TwitterClient.new }.to raise_error("Implement in subclass!")
  end
end

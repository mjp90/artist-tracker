# == Schema Information
#
# Table name: twitter_relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_twitter_relationships_on_followed_id                  (followed_id)
#  index_twitter_relationships_on_follower_id                  (follower_id)
#  index_twitter_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

require "rails_helper"

RSpec.describe TwitterRelationship, type: :model do
  let(:twitter_relationship) { build(:twitter_relationship) }

  context "validations" do
    it { should validate_presence_of(:follower_id) }
    it { should validate_presence_of(:followed_id) }
  end

  describe "validations" do
    it "should be valid" do
      expect(twitter_relationship).to be_valid
    end

    it "should require a follower_id" do
      allow(twitter_relationship).to receive(:follower_id) { nil }

      expect(twitter_relationship).to be_invalid
    end

    it "should require a followed_id" do
      allow(twitter_relationship).to receive(:followed_id) { nil }

      expect(twitter_relationship).to be_invalid
    end
  end
end

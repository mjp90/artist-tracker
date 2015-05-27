require "rails_helper"

RSpec.describe User, type: :model do
  describe "#follow_artist" do
    it "should add artist to the existing list of artists" do
      user   = create(:user)
      artist = build(:artist)

      expect { 
        user.follow_artist(artist)
      }.to change { user.artists.count }.by 1
    end
  end
end

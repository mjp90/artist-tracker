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

FactoryGirl.define do
  factory :twitter_relationship do
    follower_id 1
    followed_id 2
  end
end

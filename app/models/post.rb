# == Schema Information
#
# Table name: posts
#
#  id                  :integer          not null, primary key
#  facebook_account_id :integer          not null
#  shares_count        :integer
#  likes_count         :integer
#  comments_count      :integer
#  facebook_id         :string(255)      not null
#  message             :text
#  posted_at           :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_posts_on_facebook_account_id  (facebook_account_id)
#

class Post < ActiveRecord::Base
  belongs_to :facebook_account, :touch => true

end

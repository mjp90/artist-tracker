# == Schema Information
#
# Table name: facebook_accounts
#
#  id                 :integer          not null, primary key
#  account_owner_id   :integer
#  account_owner_type :string(255)
#  likes_count        :integer
#  facebook_id        :string(255)      not null
#  about_info         :string(255)
#  hometown           :string(255)
#  genre              :string(255)
#  bio                :text
#  banner_image_url   :text
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  facebook_accounts_on_account_owner_idx  (account_owner_id,account_owner_type) UNIQUE
#

class FacebookAccount < ActiveRecord::Base
  belongs_to :account_owner, :polymorphic => true
  has_many   :posts

  def self.create_account_for_owner(owner)
    fetched_account_info = FacebookApi.get_account_info_for_owner(owner)
    owner.create_facebook_account(fetched_account_info)
  end

  def update_posts
    found_posts       = FacebookApi.get_posts_for_account(self)

    existing_post_ids = self.posts.pluck(:facebook_id)
    found_post_ids    = found_posts.map { |t| t[:facebook_id] }
    new_post_ids      = found_post_ids - existing_post_ids
    old_post_ids      = existing_post_ids - found_post_ids

    if new_post_ids.any?
      new_posts = found_posts.last(new_post_ids.count)
      new_posts.each do |new_posts|
        self.posts.create!(new_posts)
      end
    end

    if old_post_ids.any?
      Post.where(:facebook_id => old_post_ids).destroy_all
    end

  end
end

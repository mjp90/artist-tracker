class CreateFacebookPostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer   :facebook_account_id, :null => false
      t.integer   :shares_count
      t.integer   :likes_count
      t.integer   :comments_count
      t.string    :facebook_id,         :null => false
      t.text      :message
      t.datetime  :posted_at
      t.timestamps
    end

    add_index :posts, :facebook_account_id
  end
end

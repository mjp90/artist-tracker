class CreateTwitterAccountsTable < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer  :user_id
      t.integer  :artist_id
      t.integer  :statuses_count
      t.integer  :followers_count
      t.string   :username
      t.string   :location
      t.string   :language
      t.text     :tagline
      t.text     :profile_pic_url
      t.datetime :join_date
      t.timestamps
    end

    add_index :twitter_accounts, :user_id,   :name => 'twitter_accounts_user_id_idx'
    add_index :twitter_accounts, :artist_id, :name => 'twitter_accounts_artist_id_idx'
  end
end

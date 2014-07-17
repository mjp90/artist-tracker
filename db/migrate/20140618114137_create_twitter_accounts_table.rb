class CreateTwitterAccountsTable < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.references  :account_owner,    :polymorphic => true
      t.integer     :statuses_count
      t.integer     :followers_count
      t.integer     :friends_count
      t.integer     :favorites_count
      t.string      :twitter_id,       :null => false, :unique => true
      t.string      :oauth_token,      :unique => true
      t.string      :oauth_secret,     :unique => true
      t.string      :username,         :null => false
      t.string      :location
      t.string      :language
      t.string      :profile_background_color
      t.text        :profile_background_image_url
      t.text        :profile_banner_url
      t.text        :tagline
      t.text        :profile_pic_url
      t.boolean     :verified
      t.datetime    :join_date
      t.timestamps
    end

    add_index :twitter_accounts, [:account_owner_id, :account_owner_type], :name => 'twitter_accounts_on_account_owner_idx', :unique => true
  end
end

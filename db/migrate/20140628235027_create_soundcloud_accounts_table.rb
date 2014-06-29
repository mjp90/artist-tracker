class CreateSoundcloudAccountsTable < ActiveRecord::Migration
  def change
    create_table :soundcloud_accounts do |t|
      t.references :account_owner, :polymorphic => true
      t.integer    :soundcloud_id, :null => false, :unique => true
      t.integer    :total_tracks
      t.integer    :total_followers
      t.integer    :total_following
      t.string     :display_name,  :null => false
      t.string     :country
      t.string     :city
      t.text       :api_url
      t.text       :url,           :null => false
      t.text       :avatar_url
      t.timestamps
    end

    add_index :soundcloud_accounts, [:account_owner_id, :account_owner_type], :name => 'soundcloud_accounts_on_account_owner_idx', :unique => true
  end
end

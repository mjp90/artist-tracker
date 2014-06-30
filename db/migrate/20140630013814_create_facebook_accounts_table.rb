class CreateFacebookAccountsTable < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.references :account_owner, :polymorphic => true
      t.integer    :likes_count
      t.string     :facebook_id,   :null => false
      t.string     :about_info
      t.string     :hometown
      t.string     :genre
      t.text       :bio
      t.text       :banner_image_url
      t.timestamps
    end

    add_index :facebook_accounts, [:account_owner_id, :account_owner_type], :name => 'facebook_accounts_on_account_owner_idx', :unique => true
  end
end

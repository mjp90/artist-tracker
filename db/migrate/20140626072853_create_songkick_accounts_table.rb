class CreateSongkickAccountsTable < ActiveRecord::Migration
  def change
    create_table :songkick_accounts do |t|
      t.references :account_owner, :polymorphic => true
      t.integer    :songkick_id,   :null => false, :unique => true
      t.integer    :total_concerts
      t.string     :display_name,  :null => false
      t.timestamps
    end

    add_index :songkick_accounts, [:account_owner_id, :account_owner_type], :name => 'songkick_accounts_on_account_owner_idx', :unique => true
  end
end

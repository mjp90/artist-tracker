class CreateSongkickAccountsTable < ActiveRecord::Migration
  def change
    create_table :songkick_accounts do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :songkick_id,   :null => false, :unique => true
      t.integer :total_concerts
      t.string  :display_name,  :null => false
      t.timestamps
    end

    add_index :songkick_accounts, :user_id,   :unique => true
    add_index :songkick_accounts, :artist_id, :unique => true
  end
end

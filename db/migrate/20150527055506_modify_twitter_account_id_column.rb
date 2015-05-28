class ModifyTwitterAccountIdColumn < ActiveRecord::Migration
  def up
    rename_column :twitter_accounts, :twitter_id, :twitter_uid
    change_column :twitter_accounts, :twitter_uid, :text, null: false
  end

  def down
    rename_column :twitter_accounts, :twitter_uid, :twitter_id
    change_column :twitter_accounts, :twitter_id, :text, null: false
  end
end

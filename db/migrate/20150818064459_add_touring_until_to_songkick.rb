class AddTouringUntilToSongkick < ActiveRecord::Migration
  def change
    add_column :songkick_accounts, :touring_until, :date

    rename_column :songkick_accounts, :songkick_id, :songkick_uid
  end

  def down
    remove_column :songkick_accounts, :touring_until

    rename_column :songkick_accounts, :songkick_uid, :songkick_id
  end
end

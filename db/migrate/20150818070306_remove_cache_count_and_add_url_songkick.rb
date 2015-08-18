class RemoveCacheCountAndAddUrlSongkick < ActiveRecord::Migration
  def up
    remove_column :songkick_accounts, :total_concerts

    add_column :songkick_accounts, :url, :text
  end

  def down
    add_column :songkick_accounts, :total_concerts, :integer

    remove_column :songkick_accounts, :url
  end
end

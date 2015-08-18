class RenameTweetIdentifier < ActiveRecord::Migration
  def change
    rename_column :tweets, :twitter_id, :twitter_uid
  end
end

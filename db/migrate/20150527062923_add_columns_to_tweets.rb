class AddColumnsToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :language, :text
    add_column :tweets, :truncated, :boolean
  end
end

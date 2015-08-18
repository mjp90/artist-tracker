class AddColumnsToTwitterAccount < ActiveRecord::Migration
  def change
    add_column :twitter_accounts, :display_name,                 :text
    add_column :twitter_accounts, :profile_link_color,           :text
    add_column :twitter_accounts, :profile_use_background_image, :boolean
    add_column :twitter_accounts, :status,                       :text
    add_column :twitter_accounts, :time_zone,                    :text
    add_column :twitter_accounts, :url,                          :text
  end
end

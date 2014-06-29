class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer     :twitter_account_id,    :null => false
      t.integer     :retweet_count
      t.integer     :favorites_count
      t.boolean     :is_retweet
      t.string      :twitter_id,            :null => false, :unique => true
      t.string      :retweet_hashtags,      :array => true
      t.string      :retweet_user_mentions, :array => true
      t.string      :hashtags,              :array => true
      t.string      :user_mentions,         :array => true
      t.text        :message
      t.text        :attachment_url
      t.text        :retweet_attachment_url
      t.datetime    :tweeted_at
      t.timestamps
    end

    add_index :tweets, :twitter_account_id
  end
end

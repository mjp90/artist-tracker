class CreateSoundcloudTracksTable < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer   :soundcloud_account_id
      t.integer   :soundcloud_id,   :null => false
      t.integer   :playback_count 
      t.integer   :download_count
      t.integer   :comments_count
      t.integer   :favorited_count
      t.integer   :duration
      t.string    :genre
      t.text      :purchase_url
      t.text      :title,           :null => false
      t.text      :url
      t.text      :artwork_url
      t.text      :waveform_url
      t.text      :stream_url
      t.text      :download_url
      t.text      :embedded_html
      t.datetime  :uploaded_date,   :null => false
      t.boolean   :is_commentable,  :null => false
      t.boolean   :is_downloadable, :null => false
      t.boolean   :is_streamable,   :null => false
      t.timestamps
    end

    add_index :tracks, :soundcloud_account_id
  end
end

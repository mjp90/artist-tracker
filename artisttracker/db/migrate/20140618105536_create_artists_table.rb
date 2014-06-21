class CreateArtistsTable < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      # Extras If Breaks
      t.text    :twitter_account_url
      t.text    :facebook_account_url
      t.text    :soundcloud_account_url
      t.text    :songkick_account_url

      t.string  :name, :null => false
      t.string  :country
      t.string  :city
      t.string  :state
      t.string  :music_genre, :null => false
      t.integer :age
      t.timestamps
    end

    # add_index :artists, :artist_list_id, :name => 'artists_artist_list_id_idx'
  end
end

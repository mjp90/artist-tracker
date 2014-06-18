class CreateArtistsTable < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      # t.integer :artist_list_id, :null => false
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

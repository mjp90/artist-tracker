class CreateArtistsTable < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      # Extras If Breaks
      t.text    :twitter_url
      t.text    :facebook_url
      t.text    :soundcloud_url
      t.text    :songkick_url
      t.string  :name, :null => false
      t.string  :music_genre, :null => false
      t.string  :country
      t.string  :city
      t.string  :state
      t.integer :age
      t.timestamps
    end

    add_index :artists, [:name, :music_genre], :unique => true
  end
end

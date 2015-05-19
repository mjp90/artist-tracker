class AddUniqueIndexUsersArtists < ActiveRecord::Migration
  def change
    add_index :users_artists, [ :user_id, :artist_id ], unique: true
  end
end

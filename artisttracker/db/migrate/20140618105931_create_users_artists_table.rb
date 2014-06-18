class CreateUsersArtistsTable < ActiveRecord::Migration
  def change
    create_table :users_artists, :id => false do |t|
      t.belongs_to :user
      t.belongs_to :artist
    end
  end
end

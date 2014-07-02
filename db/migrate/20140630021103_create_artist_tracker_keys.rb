class CreateArtistTrackerKeys < ActiveRecord::Migration
  def change
    create_table :artist_tracker_keys do |t|
      t.string  :facebook_access_token
    end
  end
end

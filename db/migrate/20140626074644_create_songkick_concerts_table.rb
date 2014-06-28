class CreateSongkickConcertsTable < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.integer  :songkick_account_id, :null => false
      t.integer  :songkick_id,         :null => false
      t.integer  :age_restriction
      t.float    :lat,                 :precision => 12
      t.float    :long,                :precision => 12
      t.text     :event_name,          :null => false
      t.text     :url,                 :null => false
      t.string   :city,                :null => false
      t.string   :state
      t.string   :country,             :null => false
      t.datetime :start_date
      t.timestamps
    end

    add_index :concerts, :songkick_account_id
  end
end

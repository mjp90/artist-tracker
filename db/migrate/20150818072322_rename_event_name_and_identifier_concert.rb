class RenameEventNameAndIdentifierConcert < ActiveRecord::Migration
  def change
    rename_column :concerts, :songkick_id, :songkick_uid
    rename_column :concerts, :event_name, :name
  end
end

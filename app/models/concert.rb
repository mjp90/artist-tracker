class Concert < ActiveRecord::Base
  belongs_to :songkick_account

  validates :songkick_account_id, :songkick_id, :event_name, :url, :city, :country, :presence => true
end
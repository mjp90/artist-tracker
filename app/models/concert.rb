# == Schema Information
#
# Table name: concerts
#
#  id                  :integer          not null, primary key
#  songkick_account_id :integer          not null
#  songkick_id         :integer          not null
#  age_restriction     :integer
#  lat                 :float
#  long                :float
#  event_name          :text             not null
#  url                 :text             not null
#  city                :string(255)      not null
#  state               :string(255)
#  country             :string(255)      not null
#  start_date          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_concerts_on_songkick_account_id  (songkick_account_id)
#

class Concert < ActiveRecord::Base
  belongs_to :songkick_account

  validates :songkick_account_id, :songkick_id, :event_name, :url, :city, :country, :presence => true
end

# == Schema Information
#
# Table name: concerts
#
#  id                  :integer          not null, primary key
#  songkick_account_id :integer          not null
#  songkick_uid        :integer          not null
#  age_restriction     :integer
#  lat                 :float
#  long                :float
#  name                :text             not null
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
  belongs_to :songkick_account, touch: true

  validates :songkick_account_id, :songkick_id, :event_name, :url, :city, :country, presence: true

  def truncate_concerts(songkick_account:, songkick_uids:)
    songkick_account.concerts.where.not(songkick_uid: songkick_uids).destroy_all
  end
end

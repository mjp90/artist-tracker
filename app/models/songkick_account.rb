# == Schema Information
#
# Table name: songkick_accounts
#
#  id                 :integer          not null, primary key
#  account_owner_id   :integer
#  account_owner_type :string(255)
#  songkick_uid       :integer          not null
#  display_name       :string(255)      not null
#  created_at         :datetime
#  updated_at         :datetime
#  touring_until      :date
#  url                :text
#
# Indexes
#
#  songkick_accounts_on_account_owner_idx  (account_owner_id,account_owner_type) UNIQUE
#

class SongkickAccount < ActiveRecord::Base
  belongs_to :account_owner, polymorphic: true
  has_many   :concerts, -> { order(:start_date) }

  validates :songkick_id, uniqueness: true
  validates :songkick_id, :display_name, presence: true

  def update_concerts(concerts_response)
    concerts_response.each do |concert_response|
      concerts.where(songkick_uid: concert_response[:songkick_uid]).first_or_create(concert_response)
    end

    Concert.truncate_concerts(songkick_account: self, songkick_uids: concerts_response.map { |cr| cr[:songkick_uid] })
  end
end

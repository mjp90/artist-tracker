# == Schema Information
#
# Table name: songkick_accounts
#
#  id                 :integer          not null, primary key
#  account_owner_id   :integer
#  account_owner_type :string(255)
#  songkick_id        :integer          not null
#  total_concerts     :integer
#  display_name       :string(255)      not null
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  songkick_accounts_on_account_owner_idx  (account_owner_id,account_owner_type) UNIQUE
#

class SongkickAccount < ActiveRecord::Base
  belongs_to :account_owner, :polymorphic => true
  has_many   :concerts, -> { order(:start_date) }

  validates :songkick_id, :uniqueness => true
  validates :songkick_id, :display_name, :presence => true

  def update_concerts
    found_concerts = SongkickApi.get_upcoming_concerts(self)

    existing_concert_ids = self.concerts.pluck(:songkick_id)
    found_concert_ids    = found_concerts.map { |uc| uc[:songkick_id] }
    new_concert_ids      = found_concert_ids - existing_concert_ids
    old_concert_ids      = existing_concert_ids - found_concert_ids

    if new_concert_ids.any?
      new_concerts = found_concerts.last(new_concert_ids.count)
      new_concerts.each do |new_concert|
        self.concerts.create!(new_concert)
      end
    end

    if old_concert_ids.any?
      Concert.where(:songkick_id => old_concert_ids).destroy_all
    end
  end
end

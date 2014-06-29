# == Schema Information
#
# Table name: songkick_accounts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  artist_id      :integer
#  songkick_id    :integer          not null
#  total_concerts :integer
#  display_name   :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_songkick_accounts_on_artist_id  (artist_id) UNIQUE
#  index_songkick_accounts_on_user_id    (user_id) UNIQUE
#

class SongkickAccount < ActiveRecord::Base
  has_many   :concerts
  belongs_to :user
  belongs_to :artist

  validates :user_id, :artist_id, :songkick_id, :uniqueness => true
  validates :songkick_id, :display_name, :presence => true

  def update_upcoming_concerts
    upcoming_concerts = SongkickApi.get_upcoming_concerts(self)

    concert_ids = self.concerts.pluck(:songkick_id)
    upcoming_concerts.each do |upcoming_concert|
      found_songkick_id = upcoming_concert[:songkick_id]
      concert           = Concert.where(:songkick_id => found_songkick_id).first
      
      concert ? concert.update_attributes(upcoming_concert) : self.concerts.create!(upcoming_concert)
      concert_ids.delete(found_songkick_id)
    end

    # Remove any remaining Concerts. Songkick has removed them
    Concert.where(:id => concert_ids).destroy_all
  end
end

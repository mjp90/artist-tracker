# == Schema Information
#
# Table name: artists
#
#  id             :integer          not null, primary key
#  twitter_url    :text
#  facebook_url   :text
#  soundcloud_url :text
#  songkick_url   :text
#  name           :string(255)      not null
#  music_genre    :string(255)      not null
#  country        :string(255)
#  city           :string(255)
#  state          :string(255)
#  age            :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_artists_on_name_and_music_genre  (name,music_genre) UNIQUE
#

require "rails_helper"

RSpec.describe Artist, type: :model do

end

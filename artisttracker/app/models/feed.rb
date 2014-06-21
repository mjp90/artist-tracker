class Feed < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    feed = where(:provider => auth.provider, :uid => auth.uid).first_or_create(:provider => auth.provider, :uid => auth.uid)
  end
end

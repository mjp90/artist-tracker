class Tweet < ActiveRecord::Base
  # belongs_to :twitter_account

  scope :min_tweet, -> { min(:id) }

  def self.create_for_account(account)
    
  end
end
# == Schema Information
#
# Table name: app_twitter_rate_limit_statuses
#
#  id                               :integer          not null, primary key
#  remaining_user_info_requests     :integer          default(180)
#  remaining_user_timeline_requests :integer          default(180)
#  remaining_rate_limit_requests    :integer          default(180)
#  user_info_reset_time             :datetime
#  user_timeline_reset_time         :datetime
#  rate_limit_reset_time            :datetime
#  created_at                       :datetime
#  updated_at                       :datetime
#

class AppTwitterRateLimitStatus < ActiveRecord::Base
  
  def self.rate_limit_status
    where(:id => 1).first_or_create
  end

  def self.user_account_requests_exceeded?
    rate_limit_status.remaining_user_info_requests <= 0
  end

  def self.user_timeline_requests_exceeded?
    rate_limit_status.remaining_user_timeline_requests <= 0
  end

  def self.rate_limit_status_requests_exceeded?
    rate_limit_status.remaining_rate_limit_requests <= 0
  end
end

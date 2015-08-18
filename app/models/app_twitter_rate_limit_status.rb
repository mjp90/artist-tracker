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

  def self.account_info_hit
    check_account_info_reset

    if rate_limit_status.remaining_user_info_requests == 180
      rate_limit_status.user_info_reset_time = 15.minutes.from_now
    end

    rate_limit_status.decrement(:remaining_user_info_requests)
  end

  def self.check_account_info_reset
    if rate_limit_status.user_info_reset_time <= Time.now
      rate_limit_status.remaining_user_info_requests = 180
    end
  end

  # response = client.get('/1.1/application/rate_limit_status.json')[:body]
  # user_methods        = response[:resources][:users]
end

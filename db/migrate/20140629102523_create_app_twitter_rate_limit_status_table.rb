class CreateAppTwitterRateLimitStatusTable < ActiveRecord::Migration
  def change
    create_table :app_twitter_rate_limit_statuses do |t|
      t.integer     :remaining_user_info_requests,     :default => 180
      t.integer     :remaining_user_timeline_requests, :default => 180
      t.integer     :remaining_rate_limit_requests,    :default => 180
      t.datetime    :user_info_reset_time
      t.datetime    :user_timeline_reset_time
      t.datetime    :rate_limit_reset_time
      t.timestamps
    end
  end
end

class FailedTwitterJob
  @queue = :failed_twitter_job

  def self.perform(klass_id, method)
    twitter_account = TwitterAccount.find(klass_id)
    begin
      twitter_account.send(method)
    rescue Exception => e
      # Put in failed Queue (Priority)
      self.enqueue(klass_id, method)
    end
  end

  def self.enqueue(klass_id, method)
    Resque.enqueue(self, klass_id, method)
  end
end

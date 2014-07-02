class TwitterJob
  @queue = :twitter_job

  def self.perform(klass_id, method)
    begin
      TwitterAccount.find(klass_id).send(method)
    rescue Exception => e
      # Put in failed Queue (Priority)
    end
  end

  def self.enqueue(klass_id, method)
    Resque.enqueue(self, klass_id, method)
  end
end

class TwitterJob
  @queue = :twitter_queue

  def self.perform(klass_id, method)
    begin
      TwitterAccount.find(klass_id).send(method)
    rescue Exception => e
      # Put in failed Queue (Priority)
      logger.error "TWITTER SYNC FAILED WITH ERROR #{e}"
    end
  end

  def self.enqueue(klass_id, method)
    Resque.enqueue(self, klass_id, method)
  end
end

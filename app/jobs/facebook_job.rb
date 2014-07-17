class FacebookJob
  @queue = :facebook_queue

  def self.perform(klass_id, method)
    begin
      FacebookAccount.find(klass_id).send(method)
    rescue Exception => e
      # Put in failed Queue (Priority)
      logger.error "FACEBOOK SYNC FAILED WITH ERROR #{e}"
    end
  end

  def self.enqueue(klass_id, method)
    logger.info "TWITTER - Enqueuing Job"
    Resque.enqueue(self, klass_id, method)
  end
end
class SongkickJob
  @queue = :songkick_queue

  def self.perform(klass_id, method)
    begin
      SongkickAccount.find(klass_id).send(method)
    rescue Exception => e
      # Put in failed Queue (Priority)
      logger.error "SONGKICK SYNC FAILED WITH ERROR #{e}"
    end
  end

  def self.enqueue(klass_id, method)
    Resque.enqueue(self, klass_id, method)
  end
end

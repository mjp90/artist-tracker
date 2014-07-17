class ThirdPartyRequestJob
  @queue = :third_party_request_job

  def self.perform(klass, method)
    klass.send(method)
  end

  def self.enqueue(klass, method)
    Resque.enqueue(self, klass, method)
  end
end

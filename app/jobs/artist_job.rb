class ArtistJob
  @queue = :artist_job

  def self.perform(klass, method)
    klass.method
  end

  def self.enqueue(klass, method)
    Resque.enqueue(self, klass, method)
  end
end

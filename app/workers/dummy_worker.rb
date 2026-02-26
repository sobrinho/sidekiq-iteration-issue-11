class DummyWorker
  include Sidekiq::Worker
  include SidekiqIteration::Iteration

  self.max_job_runtime = 5.seconds

  def build_enumerator(cursor:)
    array_enumerator(%w[a b c d], cursor: cursor)
  end

  def each_iteration(item)
    Sidekiq.logger.info "Processing: #{item}"
    sleep 3.seconds
  end
end

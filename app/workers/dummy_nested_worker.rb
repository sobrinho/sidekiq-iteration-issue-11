class DummyNestedWorker
  include Sidekiq::Worker
  include SidekiqIteration::Iteration

  self.max_job_runtime = 5.seconds

  def build_enumerator(cursor:)
    nested_enumerator(
      [
        ->(cursor) { array_enumerator(%w[1 2 3 4], cursor: cursor) },
        ->(item, cursor) { array_enumerator(%W[#{item}_1 #{item}_2 #{item}_3 #{item}_4], cursor: cursor) }
      ],
      cursor: cursor
    )
  end

  def each_iteration(item)
    Sidekiq.logger.info "Processing: #{item}"
    sleep 3.seconds
  end
end

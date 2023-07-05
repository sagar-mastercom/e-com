class AsyncJob
  include Sidekiq::Job

  def perform(*args)
    sleep(10)
  end
end

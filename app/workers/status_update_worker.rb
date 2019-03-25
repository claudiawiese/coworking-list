class StatusUpdateWorker
  include Sidekiq::Worker

  def perform(id)
    request = Request.find(id)
    request.update(status:'expired')
  end

  Sidekiq::Cron::Job.create(name: 'Status update worker - every 5min', cron: '*/5 * * * *', class: 'StatusUpdateWorker')
end

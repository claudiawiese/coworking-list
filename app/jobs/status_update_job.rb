class StatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(id)
    request = Request.find(id)
    request.update(status:'expired')
  end
end

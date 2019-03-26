class StatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(id)
    request = Request.find(id)
    if !request.update(status: 'confirmed')
      request.update(status: 'expired')
    else
      request.update(status: 'confirmed')
    end
  end
end

class StatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(id)
    request = Request.find(id)
    if request.status_two != "reconfirmed"
      request.update(status: 'expired')
    elsif request.status_two == "reconfirmed"
      request.update(status: 'confirmed')
    end
  end
end

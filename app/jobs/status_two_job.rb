class StatusTwoJob < ApplicationJob
queue_as :default

  def perform(id)
    request = Request.find(id)
    if request.status_two == "reconfirmed"
      request.update(status_two: nil)
    elsif request.status_two != "reconfirmed"
      request.update(status_two: nil)
    end
  end
end

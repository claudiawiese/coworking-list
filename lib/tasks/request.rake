namespace :request do
  desc "Update status of request on a regular basis"
  task status_update: :environment do
    @request = Request.first
    StatusUpdateJob.perform_now(@request.id)
  end
end

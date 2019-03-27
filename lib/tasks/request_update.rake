namespace :request_update do
  desc "Update status two to nil every two months"
  task status_two_update: :environment do
    @request = Request.first
    StatusTwoJob.perform_now(@request.id)
  end
end

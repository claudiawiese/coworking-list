desc 'send confirmation three months'
task send_confirmation_three_months: :environment do
    @request = Request.last
    if @request.status == "confirmed"
      ClientMailer.confirmation_three_months(@request).deliver!
    end
end

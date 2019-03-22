desc 'send confirmation three months'
task send_confirmation_three_months: :environment do
    @requests = Request.all
    @requests.each {|request|
    if request.status == "accepted"
      ClientMailer.confirmation_three_months(request).deliver!
    end}
end

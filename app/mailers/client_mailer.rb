class ClientMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_mailer.confirmation.subject
  #

  def confirmation_email(request)
    @request = request
    mail(
      to:       @request.email,
      subject:  "Email Confirmation"
    )
  end

  def confirmation_three_months(request)
  @request = request
    mail(
      to:       request.email,
      subject:  "Waiting List Subscription - Confirmation"
    )
  end
end

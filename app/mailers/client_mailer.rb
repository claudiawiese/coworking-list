class ClientMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_mailer.confirmation.subject
  #

  def confirmation_email(request)
    @request = Request.last
    mail(
      to:       @request.email,
      subject:  "Email Confirmation"
    )
  end
end

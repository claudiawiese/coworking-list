# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/client_mailer/confirmation
  def confirmation
  request = Request.last
  ClientMailer.confirmation_email(request)
  end

end

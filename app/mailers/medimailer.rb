class Medimailer < ActionMailer::Base
   default from:"torreta.sendgrid.net"
  def recover_account_email(user, new_password)
      @user = user
      @pass = new_password
    mail(to: @user.email, subject: "Heres your new password #{new_password}")
  end
  
end

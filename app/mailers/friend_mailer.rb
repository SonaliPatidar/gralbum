class FriendMailer < ApplicationMailer
  def mail_password_to_friend(user)
    @user = user
    mail(to: @user.email, from: "gralbum@grepruby.com", subject: "Reset Password from Gralbum")
  end
end
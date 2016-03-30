class UserMailer < ApplicationMailer
  default from: 'gralbums@grepruby.com'
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to gralbum')
  end

  def send_password(user)
  	@user = user
  	mail(to: @user.email, subject: 'Your Gralbum password' )
  end	
end

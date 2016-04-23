class CommentMailer < ApplicationMailer
  def mail_photo_delete(photo, receiver)
  	@receiver = receiver
  	@photo = photo
  	@receiver.user_name
    mail(to: @receiver.email, from: "gralbum@grepruby.com", subject: 'Photo Deleted')
  end	
end
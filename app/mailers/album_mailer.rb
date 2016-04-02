class AlbumMailer < ApplicationMailer
	def mail_my_album(receiver,album)
	  @receiver = receiver
      @album = album
      mail(to: @receiver.email, from: @album.user.email, subject: 'Photos from gralbum')
    end		
end

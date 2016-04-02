class PhotosController < ApplicationController
  before_action :authenticate_user!

  def show
    @photo = Photo.find(params[:id])
  	@album = @photo.album
    @comment = Comment.new
    @comments = @photo.comments
  end	

 def destroy
  	@photo = Photo.find(params[:id])
  	@album = @photo.album
  	if @photo.comments
	  @photo.comments.each do |comment|
	    CommentMailer.mail_photo_delete(@photo, comment.user).deliver_now
	  end
	end    
  	if @photo.destroy
  	  render :partial => "albums/delete_photo", :locals => {album: @album}	
    else
      flash[:error] = "Not deleted"
    end  
  end
  
end

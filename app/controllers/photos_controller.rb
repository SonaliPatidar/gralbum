class PhotosController < ApplicationController
  before_action :authenticate_user!

  def show
    @photo = Photo.find(params[:id])
  	@album = @photo.album
    @comment = Comment.new
    @comments = @photo.comments
  end	

 def destroy
  	@photo = current_user.photos.find(params[:id])
  	@album = @photo.album
    if @photo.comments
      @photo.comments.pluck(:user_id).uniq.each do |user_id|
        @user = User.find(user_id)
        CommentMailer.mail_photo_delete(@photo, @user).deliver_now
      end
    end  
  	if @photo.destroy
      render :partial => "albums/delete_photo", :locals => {album: @album}	
    end
  end
end
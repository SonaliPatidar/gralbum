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
  	@user = @album.user
  	if @photo.destroy
  	  redirect_to user_album_path(@user.id, @album.id), notice: 'Photo was successfully deleted.'
    else
      flash[:error] = "Not deleted"
    end  
  end
  
end

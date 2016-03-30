class CommentsController < ApplicationController
    before_action :authenticate_user!
	def new
  end	

    def create
      @photo = Photo.find(params[:photo_id])
  	  @comment = @photo.comments.new(comment_params)
  	  @comment.user_id = @current_user.id
      if @comment.save
        redirect_to user_album_photo_path(@current_user.id,  @photo.album.id, @photo.id)
        flash[:success] = "Comment Posted Successfully"
      else
      flash[:error] = @comment.errors.full_messages.join('.').html_safe
      redirect_to user_album_photo_path(@current_user.id, @photo.album.id, @photo.id), method: :post
      end	
    end 	

    private		

    def comment_params
      params.require(:comment).permit(:comment_name)
    end
end
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.find(params[:photo_id])
	  @comment = @photo.comments.new(comment_params)
	  @comment.user_id = current_user.id
    if @comment.save
  	  render :partial => 'photos/photo_comments', :locals => {comments: @photo.comments}
    else
      flash[:error] = @comment.errors.full_messages.join('.').html_safe
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_name)
  end
end
class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = Friend.where('(friend_id = ? OR user_id = ?) AND status = "Approve"',current_user.id, current_user.id)
    @user_id = @friends.pluck(:user_id, :friend_id).flatten
    @users = User.where(id: @user_id).where.not(id: current_user.id).pluck(:id).uniq
    @albums = Album.where(user_id: @users, publish: true).paginate(page: params[:page], per_page: 30)
  end

  def new
    @album = Album.new
    @album.photos.new
  end
 
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos
  end

  def edit
    @album = current_user.albums.find(params[:id])
    if @album.blank?
      flash[:error]="Unauthorise user"
      redirect_to my_album_user_albums_path(current_user)
    end  
  end	

  def create
    @album = current_user.albums.new(album_params)
      if @album.save
       redirect_to my_album_user_albums_path(current_user),notice: 'Album was successfully created.'
      else
       flash[:error] = @album.errors.full_messages.join('.').html_safe
       render 'new' 
      end  	
  end

  def update
    @album = current_user.albums.find(params[:id])
  	if @album.update(album_params)
      @album.photos.each do |photo|
        if photo.changed? && photo.comments.present?
          photo.comments.destroy_all
        end
      end   
      redirect_to my_album_user_albums_path(current_user), notice: 'album was successfully updated.'
    else
      flash[:error] = @album.errors.full_messages.join('.').html_safe
      redirect_to edit_user_album_path(current_user,@album)
    end  
  end	

  def destroy
    @album = current_user.albums.find(params[:id])
    if @album.destroy
      redirect_to my_album_user_albums_path(current_user), notice: 'album was successfully deleted.'
    else
      flash[:error] = "Not deleted"
    end 
  end

  def my_album
    @albums = current_user.albums.paginate(page: params[:page], per_page: 30)
  end  

  def make_cover
    @album = current_user.albums.find(params[:id])
    @album.photos.update_all(cover_photo: false)
    @photo = @album.photos.find(params[:photo_id])
    if @photo.update(cover_photo: true)
      redirect_to my_album_user_albums_path(current_user), notice: 'Cover page is set.'  
    end 
  end 

  def  share_album
    @album = current_user.albums.find(params[:id])
  end

  def  sent_album
    @user = User.find_by_email(params[:email])
    @album = current_user.albums.find(params[:id])
    if @user.present? 
      AlbumMailer.mail_my_album(@user, @album).deliver_now 
      redirect_to my_album_user_albums_path(current_user), notice: 'Album send successfully'
    else
      flash[:error] ="Invalid email"
      redirect_to share_album_user_album_path(current_user.id, @album.id)
    end  
  end   

  private		

  def album_params
      params.require(:album).permit(:name, :description, :publish, :photos_attributes => [:id, :album_id, :image, :user_id])
  end
end
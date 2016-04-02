class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = Album.where.not(user_id: current_user, publish: false).paginate(page: params[:page], per_page: 2)
  end

  def new
    @album = Album.new
    @album.photos.new
  end
 
  def show
    @album = Album.find_by_id(params[:id])
    @photos = @album.photos
  end

  def edit
    if @album = current_user.albums.find_by_id(params[:id])
       @user = current_user
    else
      flash[:error]="Unauthorise user"
      redirect_to my_album_user_albums_path(current_user)
    end  

  end	

  def create
    @album = current_user.albums.new(album_params)
    if @album.photos.present?
      @album.photos.each do |photo| photo.user_id = current_user.id end
      if @album.save
       redirect_to my_album_user_albums_path(current_user),notice: 'Album was successfully created.'
      else
       flash[:error] = @album.errors.full_messages.join('.').html_safe
       redirect_to new_user_album_path
      end
    else
      flash[:error] = "Please select photo"
      redirect_to new_user_album_path
    end  	
  end

  def update
    @album = current_user.albums.find(params[:id])
  	if @album.update(album_params)
      redirect_to my_album_user_albums_path(current_user), notice: 'album was successfully updated.'
    else
      flash[:error] = @album.errors.full_messages.join('.').html_safe
      redirect_to edit_user_album_path(current_user,@album)
    end  
  end	

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      redirect_to my_album_user_albums_path(current_user), notice: 'album was successfully deleted.'
    else
      flash[:error] = "Not deleted"
    end 
  end

  def my_album
    @albums = current_user.albums.paginate(page: params[:page], per_page: 2)
  end  

  def make_cover
    @album = Album.find(params[:id])
    @album.photos.update_all(cover_photo: false)
    @photo = @album.photos.find(params[:photo_id])
    if @photo.update(cover_photo: true)
      redirect_to my_album_user_albums_path(current_user), notice: 'Cover page is set.'  
    end 
  end 

  def  share_album
    @album = Album.find(params[:id])
  end

  def  sent_album
    @user = User.where(email: params[:email]).first
    @album = Album.find(params[:id])
    if @user 
    AlbumMailer.mail_my_album(@user, @album).deliver_now 
    redirect_to my_album_user_albums_path(current_user), notice: 'Mail send successfully'
    else
      flash[:error] ="Invalid email"
      redirect_to share_album_user_album_path(current_user.id, @album.id)
    end  
  end   

  private		

  def album_params
      params.require(:album).permit(:name, :description, :publish, :photos_attributes => [:id, :album_id, :image, :_destroy])
  end
end
module AlbumsHelper
  def album_cover_photo(album)
  	@album = album
  	@photo = @album.photos.where(cover_photo: true).first
  	if @photo.present?
      @photo.image.url
	elsif @album.photos.present?
	  @album.photos.first.image.url
	else
	   image_url("default.jpeg")
	end 
  end	
end

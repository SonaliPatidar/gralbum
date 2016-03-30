class AddCoverPhotoToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos, :cover_photo, :boolean, :default => false
  end
end

class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :image
      t.integer :user_id, index: true
      t.integer :album_id, index:true	
      
      t.timestamps null: false
    end
  end
end

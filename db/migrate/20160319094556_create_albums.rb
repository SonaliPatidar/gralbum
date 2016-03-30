class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :description
      t.boolean :publish
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end

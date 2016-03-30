class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_name
      t.integer :user_id, index: true
      t.integer :photo_id, index:true

      t.timestamps null: false
    end
  end
end

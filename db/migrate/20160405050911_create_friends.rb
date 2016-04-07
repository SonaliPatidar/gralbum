class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.string :status
      t.integer :user_id, index: true		

      t.timestamps null: false
    end
  end
end

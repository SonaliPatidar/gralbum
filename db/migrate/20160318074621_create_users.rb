class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :team
      t.string :role
      t.boolean :approve, :default => false

      t.timestamps null: false
    end
  end
end

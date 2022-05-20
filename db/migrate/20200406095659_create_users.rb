class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password
      t.string :name
      t.string :phone
      t.string :profile_picture_url
      t.integer :status, default: 1
      t.boolean :is_web_user, default: false
      t.boolean :is_superuser, default: false
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :role_id

      t.timestamps
    end
    add_index :users, :id
    add_index :users, :role_id
  end
end

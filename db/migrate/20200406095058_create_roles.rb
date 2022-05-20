class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :title, null: false
      t.integer :status, default: 1
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :roles, :id
  end
end

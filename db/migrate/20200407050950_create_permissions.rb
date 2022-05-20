class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.integer :status, default: 1
      t.string :icon
      t.string :path
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :permissions, :id
  end
end

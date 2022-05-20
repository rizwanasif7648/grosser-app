class CreateRolePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :role_permissions do |t|
      t.references :role, foreign_key: true
      t.references :permission, foreign_key: true
      t.integer :status, default: 1
      t.boolean :is_readable, default: false
      t.boolean :is_createable, default: false
      t.boolean :is_updateable, default: false
      t.boolean :is_deleteable, default: false
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end

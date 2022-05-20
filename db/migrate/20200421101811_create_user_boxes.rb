class CreateUserBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_boxes do |t|
      t.references :customer, foreign_key: true
      t.references :user, foreign_key: true
      t.references :box, foreign_key: true
      t.integer :status, default: 1
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :user_boxes, :id
  end
end

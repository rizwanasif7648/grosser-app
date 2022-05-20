class CreateBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :boxes do |t|
      t.string :code
      t.references :customer, foreign_key: true
      t.string :location, null: false
      t.string :box_type
      t.integer :status, default: 1
      t.integer :min_products
      t.integer :max_products
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :boxes, :id
  end
end

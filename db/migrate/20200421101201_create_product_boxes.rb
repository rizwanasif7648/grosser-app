class CreateProductBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_boxes do |t|
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true
      t.references :box, foreign_key: true
      t.integer :status, default: 1
      t.integer :count
      t.integer :threshold
      t.datetime :expiry
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :product_boxes, :id
  end
end

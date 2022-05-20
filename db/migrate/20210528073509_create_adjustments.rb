class CreateAdjustments < ActiveRecord::Migration[5.2]
  def change
    create_table :adjustments do |t|
      t.datetime :expiry_before
      t.datetime :expiry_after
      t.integer :quantity_before
      t.integer :quantity_after
      t.string :product_name
      t.bigint :customer_id
      t.bigint :box_id
      t.bigint :product_id
      t.bigint :created_by_id
      t.integer :threshold_before
      t.integer :threshold_after
      t.text :notes

      t.timestamps
    end
  end
end

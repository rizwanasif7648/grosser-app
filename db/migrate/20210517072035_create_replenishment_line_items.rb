class CreateReplenishmentLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :replenishment_line_items do |t|
      t.string :product_name
      t.integer :quantity_before
      t.integer :quantity_after
      t.integer :quantity
      t.datetime :expiry_before
      t.datetime :expiry_after
      t.bigint :replenishment_id
      t.bigint :customer_id
      t.bigint :box_id
      t.bigint :product_id

      t.timestamps
    end
  end
end

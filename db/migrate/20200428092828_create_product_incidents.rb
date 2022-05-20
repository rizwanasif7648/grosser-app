class CreateProductIncidents < ActiveRecord::Migration[5.2]
  def change
    create_table :product_incidents do |t|
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true
      t.references :incident, foreign_key: true
      t.references :box, foreign_key: true
      t.integer :quantity
      t.integer :balance
      t.datetime :expiry
      t.integer :status, default: 1
      t.bigint :created_by_id
      t.bigint :updated_by_id

      t.timestamps
    end
  end
end

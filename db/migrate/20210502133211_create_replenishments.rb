class CreateReplenishments < ActiveRecord::Migration[5.2]
  def change
    create_table :replenishments do |t|
      t.string :po_no, null: false
      t.datetime :po_issuance
      t.string :quotation_no
      t.string :location
      t.text :notes
      t.datetime :added_date
      t.bigint :created_by_id
      t.bigint :customer_id
      t.bigint :box_id

      t.timestamps
    end
  end
end

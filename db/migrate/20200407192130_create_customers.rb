class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :code
      t.string :name
      t.string :url
      t.string :email, null: false
      t.string :phone
      t.string :street_address
      t.string :country
      t.string :state
      t.string :city
      t.string :postcode
      t.integer :status, default: 1
      t.string :industry
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :customers, :id
  end
end

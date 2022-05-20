class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name, null: false
      t.text :description
      t.string :category
      t.string :brand
      t.string :asset_type
      t.boolean :is_expirable, default: false
      t.string :photo_url
      t.integer :status, default: 1
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :products, :id
  end
end

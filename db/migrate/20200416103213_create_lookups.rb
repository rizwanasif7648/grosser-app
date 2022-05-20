class CreateLookups < ActiveRecord::Migration[5.2]
  def change
    create_table :lookups do |t|
      t.integer :category
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end

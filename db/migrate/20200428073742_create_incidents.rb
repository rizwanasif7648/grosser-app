class CreateIncidents < ActiveRecord::Migration[5.2]
  def change
    create_table :incidents do |t|
      t.references :customer, foreign_key: true
      t.references :user, foreign_key: true
      t.references :box, foreign_key: true
      t.datetime :date_time
      t.integer :status, default: 1
      t.bigint :created_by_id
      t.bigint :updated_by_id

      t.timestamps
    end
    add_index :incidents, :id
  end
end

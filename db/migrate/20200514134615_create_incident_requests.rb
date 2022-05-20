class CreateIncidentRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :incident_requests do |t|
      t.references :customer, foreign_key: true
      t.references :user, foreign_key: true
      t.string :image
      t.bigint :created_by_id
      t.bigint :updated_by_id

      t.timestamps
    end
  end
end

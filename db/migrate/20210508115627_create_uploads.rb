class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.string :photo
      t.string :note
      t.bigint :replenishment_id

      t.timestamps
    end
  end
end

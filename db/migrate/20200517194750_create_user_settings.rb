class CreateUserSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_settings do |t|
      t.string :notification
      t.integer :notification_type
      t.boolean :flag
      t.bigint :user_id

      t.timestamps
    end
  end
end

class CreateSupports < ActiveRecord::Migration[5.2]
  def change
    create_table :supports do |t|
      t.string :to
      t.string :from
      t.string :title
      t.string :body_message

      t.timestamps
    end
  end
end

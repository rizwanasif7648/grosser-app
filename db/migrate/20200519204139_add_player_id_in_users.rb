class AddPlayerIdInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :player_id, :string
  end
end

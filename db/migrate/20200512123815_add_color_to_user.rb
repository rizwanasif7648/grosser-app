class AddColorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :color, :string, default: 'bg-blue'
  end
end

class AddColorToBox < ActiveRecord::Migration[5.2]
  def change
    add_column :boxes, :color, :string, default: 'bg-blue'
  end
end

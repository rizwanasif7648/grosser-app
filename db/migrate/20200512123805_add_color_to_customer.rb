class AddColorToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :color, :string, default: 'bg-blue'
  end
end

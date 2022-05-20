class ChangeDefaultValueOfProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :is_expirable, :boolean, :default => true
  end
end

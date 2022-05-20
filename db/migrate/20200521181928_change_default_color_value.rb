class ChangeDefaultColorValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :boxes, :color, 'health-blue'
    change_column_default :customers, :color, 'health-blue'
    change_column_default :users, :color, 'health-blue'
  end
end

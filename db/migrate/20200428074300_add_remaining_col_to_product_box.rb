class AddRemainingColToProductBox < ActiveRecord::Migration[5.2]
  def change
  	add_column :product_boxes, :remaining, :integer
  end
end

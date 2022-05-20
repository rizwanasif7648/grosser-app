class CreateProductsByBoxesViews < ActiveRecord::Migration[5.2]
  def change
    create_view :products_by_boxes_views, version: 1, materialized: true
  end
end

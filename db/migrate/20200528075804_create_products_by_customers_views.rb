class CreateProductsByCustomersViews < ActiveRecord::Migration[5.2]
  def change
    create_view :products_by_customers_views, version: 1, materialized: true
  end
end

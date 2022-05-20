class CreateBoxesByCustomersViews < ActiveRecord::Migration[5.2]
  def change
    create_view :boxes_by_customers_views, version: 1, materialized: true
  end
end

class UpdateProductsByBoxesThreeMonthViewsToVersion2 < ActiveRecord::Migration[6.1]
  def change
    update_view :products_by_boxes_three_month_views, version: 2, revert_to_version: 1, materialized: true
  end
end

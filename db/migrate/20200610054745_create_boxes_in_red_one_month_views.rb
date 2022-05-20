class CreateBoxesInRedOneMonthViews < ActiveRecord::Migration[5.2]
  def change
    create_view :boxes_in_red_one_month_views, version: 1, materialized: true
  end
end

class CreateBoxesInRedThreeMonthViews < ActiveRecord::Migration[5.2]
  def change
    create_view :boxes_in_red_three_month_views, version: 1, materialized: true
  end
end

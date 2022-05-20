class CreateBoxesInRedSixMonthViews < ActiveRecord::Migration[5.2]
  def change
    create_view :boxes_in_red_six_month_views, version: 1, materialized: true
  end
end

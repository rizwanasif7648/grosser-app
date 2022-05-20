class CreateBoxesInRedWeekViews < ActiveRecord::Migration[5.2]
  def change
    create_view :boxes_in_red_week_views, version: 1, materialized: true
  end
end

class CreateIncidentsByCustomersWeekViews < ActiveRecord::Migration[5.2]
  def change
    create_view :incidents_by_customers_week_views, version: 1, materialized: true
  end
end

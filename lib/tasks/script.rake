# frozen_string_literal: true

namespace :script do
  desc 'Expire those product boxes whose expiry date has arrived'
  task expire_product_boxes: :environment do
    expirable_product_boxes = ProductBox.where(expiry: Date.yesterday)
    expirable_product_boxes.each(&:expire_the_product_box)
  end

  desc 'Check for those products which are expiring in 2 months'
  task check_expiring_products: :environment do
    expirable_product_boxes = ProductBox.where(expiry: Date.today + 2.months)
    expirable_product_boxes.each(&:product_expiring_soon)
  end

  desc 'Add roles_permissions against permission'
  task add_roles_permissions: :environment do
    Role.all.each do |role|
      Permission.all.each do |permission|
        next if RolePermission.where(role_id: role.id, permission_id: permission.id).present?

        RolePermission.create!(role_id: role.id, permission_id: permission.id, status: 1,
                               is_readable: false, is_createable: false, is_updateable: false,
                               is_deleteable: false)
      end
    end
  end

  task database_views_refresh: :environment do
    Scenic.database.refresh_materialized_view('boxes_by_customers_views',
                                              concurrently: false, cascade: false)

    Scenic.database.refresh_materialized_view('products_by_customers_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_customers_week_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_customers_one_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_customers_three_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_customers_six_month_views',
                                              concurrently: false, cascade: false)

    Scenic.database.refresh_materialized_view('products_by_boxes_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_boxes_week_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_boxes_one_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_boxes_three_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('products_by_boxes_six_month_views',
                                              concurrently: false, cascade: false)

    Scenic.database.refresh_materialized_view('incidents_by_customers_week_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('incidents_by_customers_one_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('incidents_by_customers_three_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('incidents_by_customers_six_month_views',
                                              concurrently: false, cascade: false)

    Scenic.database.refresh_materialized_view('boxes_in_red_week_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('boxes_in_red_one_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('boxes_in_red_three_month_views',
                                              concurrently: false, cascade: false)
    Scenic.database.refresh_materialized_view('boxes_in_red_six_month_views',
                                              concurrently: false, cascade: false)
  end
end

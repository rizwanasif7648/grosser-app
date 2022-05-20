# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_15_103902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "adjustments", force: :cascade do |t|
    t.datetime "expiry_before"
    t.datetime "expiry_after"
    t.integer "quantity_before"
    t.integer "quantity_after"
    t.string "product_name"
    t.bigint "customer_id"
    t.bigint "box_id"
    t.bigint "product_id"
    t.bigint "created_by_id"
    t.integer "threshold_before"
    t.integer "threshold_after"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "boxes", force: :cascade do |t|
    t.string "code"
    t.bigint "customer_id"
    t.string "location", null: false
    t.string "box_type"
    t.integer "status", default: 1
    t.integer "min_products"
    t.integer "max_products"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qrcode_url"
    t.string "color", default: "health-blue"
    t.index ["customer_id"], name: "index_boxes_on_customer_id"
    t.index ["id"], name: "index_boxes_on_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "url"
    t.string "email", null: false
    t.string "phone"
    t.string "street_address"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "postcode"
    t.integer "status", default: 1
    t.string "industry"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color", default: "health-blue"
    t.index ["id"], name: "index_customers_on_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "incident_requests", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "user_id"
    t.string "image"
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_incident_requests_on_customer_id"
    t.index ["user_id"], name: "index_incident_requests_on_user_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "user_id"
    t.bigint "box_id"
    t.datetime "date_time"
    t.integer "status", default: 1
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_id"], name: "index_incidents_on_box_id"
    t.index ["customer_id"], name: "index_incidents_on_customer_id"
    t.index ["id"], name: "index_incidents_on_id"
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "lookups", force: :cascade do |t|
    t.integer "category"
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.integer "notification_type"
    t.bigint "user_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "read_at"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 1
    t.string "icon"
    t.string "path"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_permissions_on_id"
  end

  create_table "product_boxes", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "product_id"
    t.bigint "box_id"
    t.integer "status", default: 1
    t.integer "count"
    t.integer "threshold"
    t.datetime "expiry"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "remaining"
    t.index ["box_id"], name: "index_product_boxes_on_box_id"
    t.index ["customer_id"], name: "index_product_boxes_on_customer_id"
    t.index ["id"], name: "index_product_boxes_on_id"
    t.index ["product_id"], name: "index_product_boxes_on_product_id"
  end

  create_table "product_incidents", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "product_id"
    t.bigint "incident_id"
    t.bigint "box_id"
    t.integer "quantity"
    t.integer "balance"
    t.datetime "expiry"
    t.integer "status", default: 1
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_id"], name: "index_product_incidents_on_box_id"
    t.index ["customer_id"], name: "index_product_incidents_on_customer_id"
    t.index ["incident_id"], name: "index_product_incidents_on_incident_id"
    t.index ["product_id"], name: "index_product_incidents_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name", null: false
    t.text "description"
    t.string "category"
    t.string "brand"
    t.string "asset_type"
    t.boolean "is_expirable", default: true
    t.string "photo"
    t.integer "status", default: 1
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qrcode_url"
    t.index ["id"], name: "index_products_on_id"
  end

  create_table "replenishment_line_items", force: :cascade do |t|
    t.string "product_name"
    t.integer "quantity_before"
    t.integer "quantity_after"
    t.integer "quantity"
    t.datetime "expiry_before"
    t.datetime "expiry_after"
    t.bigint "replenishment_id"
    t.bigint "customer_id"
    t.bigint "box_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "replenishments", force: :cascade do |t|
    t.string "po_no", null: false
    t.datetime "po_issuance"
    t.string "quotation_no"
    t.string "location"
    t.text "notes"
    t.datetime "added_date"
    t.bigint "created_by_id"
    t.bigint "customer_id"
    t.bigint "box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "permission_id"
    t.integer "status", default: 1
    t.boolean "is_readable", default: false
    t.boolean "is_createable", default: false
    t.boolean "is_updateable", default: false
    t.boolean "is_deleteable", default: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", null: false
    t.integer "status", default: 1
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_roles_on_customer_id"
    t.index ["id"], name: "index_roles_on_id"
  end

  create_table "supports", force: :cascade do |t|
    t.string "to"
    t.string "from"
    t.string "title"
    t.string "body_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string "photo"
    t.string "note"
    t.bigint "replenishment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_boxes", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "user_id"
    t.bigint "box_id"
    t.integer "status", default: 1
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_id"], name: "index_user_boxes_on_box_id"
    t.index ["customer_id"], name: "index_user_boxes_on_customer_id"
    t.index ["id"], name: "index_user_boxes_on_id"
    t.index ["user_id"], name: "index_user_boxes_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.string "notification"
    t.integer "notification_type"
    t.boolean "flag"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "phone"
    t.string "profile_picture"
    t.integer "status", default: 1
    t.boolean "is_web_user", default: true
    t.boolean "is_superuser", default: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "customer_id"
    t.string "color", default: "health-blue"
    t.string "player_id"
    t.index ["customer_id"], name: "index_users_on_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boxes", "customers"
  add_foreign_key "incident_requests", "customers"
  add_foreign_key "incident_requests", "users"
  add_foreign_key "incidents", "boxes"
  add_foreign_key "incidents", "customers"
  add_foreign_key "incidents", "users"
  add_foreign_key "product_boxes", "boxes"
  add_foreign_key "product_boxes", "customers"
  add_foreign_key "product_boxes", "products"
  add_foreign_key "product_incidents", "boxes"
  add_foreign_key "product_incidents", "customers"
  add_foreign_key "product_incidents", "incidents"
  add_foreign_key "product_incidents", "products"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "roles", "customers"
  add_foreign_key "user_boxes", "boxes"
  add_foreign_key "user_boxes", "customers"
  add_foreign_key "user_boxes", "users"
  add_foreign_key "users", "customers"

  create_view "boxes_by_customers_views", materialized: true, sql_definition: <<-SQL
      SELECT customers.id,
      customers.name,
      COALESCE(boxes.color, 'health-blue'::character varying) AS color,
      count(boxes.color) AS count
     FROM (customers
       LEFT JOIN boxes ON ((customers.id = boxes.customer_id)))
    WHERE (boxes.status <> 2)
    GROUP BY boxes.color, customers.id, customers.name
    ORDER BY customers.id;
  SQL
  create_view "boxes_in_red_one_month_views", materialized: true, sql_definition: <<-SQL
      SELECT a.week,
      b.customer_id,
      b.boxes
     FROM (( SELECT date_part('week'::text, (dd.dd)::date) AS week
             FROM generate_series(((CURRENT_DATE - 30))::timestamp with time zone, ((CURRENT_DATE - 1))::timestamp with time zone, 'P7D'::interval) dd(dd)) a
       LEFT JOIN ( SELECT date_part('week'::text, (boxes.updated_at)::date) AS week,
              boxes.customer_id,
              count(boxes.customer_id) AS boxes
             FROM boxes
            WHERE ((boxes.updated_at > (CURRENT_DATE - 'P1M'::interval)) AND ((boxes.color)::text = 'health-red'::text) AND (boxes.status <> 2))
            GROUP BY (date_part('week'::text, (boxes.updated_at)::date)), boxes.customer_id) b ON ((a.week = b.week)));
  SQL
  create_view "boxes_in_red_three_month_views", materialized: true, sql_definition: <<-SQL
      SELECT a."Month",
      b.customer_id,
      b.boxes
     FROM (( SELECT to_char(dd.dd, 'Mon'::text) AS "Month"
             FROM generate_series((CURRENT_DATE - 'P3M'::interval), (CURRENT_DATE)::timestamp without time zone, 'P1M'::interval) dd(dd)) a
       LEFT JOIN ( SELECT to_char(boxes.updated_at, 'Mon'::text) AS "Month",
              boxes.customer_id,
              count(boxes.customer_id) AS boxes
             FROM boxes
            WHERE ((boxes.updated_at > (CURRENT_DATE - 'P3M'::interval)) AND ((boxes.color)::text = 'health-red'::text) AND (boxes.status <> 2))
            GROUP BY (to_char(boxes.updated_at, 'Mon'::text)), boxes.customer_id) b ON ((a."Month" = b."Month")));
  SQL
  create_view "boxes_in_red_six_month_views", materialized: true, sql_definition: <<-SQL
      SELECT a."Month",
      b.customer_id,
      b.boxes
     FROM (( SELECT to_char(dd.dd, 'Mon'::text) AS "Month"
             FROM generate_series((CURRENT_DATE - 'P6M'::interval), (CURRENT_DATE)::timestamp without time zone, 'P1M'::interval) dd(dd)) a
       LEFT JOIN ( SELECT to_char(boxes.updated_at, 'Mon'::text) AS "Month",
              boxes.customer_id,
              count(boxes.customer_id) AS boxes
             FROM boxes
            WHERE ((boxes.updated_at > (CURRENT_DATE - 'P6M'::interval)) AND ((boxes.color)::text = 'health-red'::text) AND (boxes.status <> 2))
            GROUP BY (to_char(boxes.updated_at, 'Mon'::text)), boxes.customer_id) b ON ((a."Month" = b."Month")));
  SQL
  create_view "boxes_in_red_week_views", materialized: true, sql_definition: <<-SQL
      SELECT a.date,
      b.customer_id,
      b.boxes
     FROM (( SELECT (date_trunc('day'::text, dd.dd))::date AS date
             FROM generate_series(((CURRENT_DATE - 7))::timestamp with time zone, ((CURRENT_DATE - 1))::timestamp with time zone, 'P1D'::interval) dd(dd)) a
       LEFT JOIN ( SELECT (boxes.updated_at)::date AS date,
              boxes.customer_id,
              count(boxes.customer_id) AS boxes
             FROM boxes
            WHERE ((boxes.updated_at > (CURRENT_DATE - 7)) AND ((boxes.color)::text = 'health-red'::text) AND (boxes.status <> 2))
            GROUP BY ((boxes.updated_at)::date), boxes.customer_id) b ON ((a.date = b.date)));
  SQL
  create_view "incidents_by_customers_one_month_views", materialized: true, sql_definition: <<-SQL
      SELECT a.week,
      b.customer_id,
      b.incidents
     FROM (( SELECT date_part('week'::text, (dd.dd)::date) AS week
             FROM generate_series(((CURRENT_DATE - 30))::timestamp with time zone, ((CURRENT_DATE - 1))::timestamp with time zone, 'P7D'::interval) dd(dd)) a
       LEFT JOIN ( SELECT date_part('week'::text, (product_incidents.created_at)::date) AS week,
              product_incidents.customer_id,
              count(product_incidents.customer_id) AS incidents
             FROM product_incidents
            WHERE ((product_incidents.created_at > (CURRENT_DATE - 'P1M'::interval)) AND (product_incidents.status <> 2))
            GROUP BY (date_part('week'::text, (product_incidents.created_at)::date)), product_incidents.customer_id) b ON ((a.week = b.week)));
  SQL
  create_view "incidents_by_customers_six_month_views", materialized: true, sql_definition: <<-SQL
      SELECT a."Month",
      b.customer_id,
      b.incidents
     FROM (( SELECT to_char(dd.dd, 'Mon'::text) AS "Month"
             FROM generate_series((CURRENT_DATE - 'P6M'::interval), (CURRENT_DATE)::timestamp without time zone, 'P1M'::interval) dd(dd)) a
       LEFT JOIN ( SELECT to_char(product_incidents.created_at, 'Mon'::text) AS "Month",
              product_incidents.customer_id,
              count(product_incidents.customer_id) AS incidents
             FROM product_incidents
            WHERE ((product_incidents.created_at > (CURRENT_DATE - 'P6M'::interval)) AND (product_incidents.status <> 2))
            GROUP BY (to_char(product_incidents.created_at, 'Mon'::text)), product_incidents.customer_id) b ON ((a."Month" = b."Month")));
  SQL
  create_view "incidents_by_customers_three_month_views", materialized: true, sql_definition: <<-SQL
      SELECT a."Month",
      b.customer_id,
      b.incidents
     FROM (( SELECT to_char(dd.dd, 'Mon'::text) AS "Month"
             FROM generate_series((CURRENT_DATE - 'P3M'::interval), (CURRENT_DATE)::timestamp without time zone, 'P1M'::interval) dd(dd)) a
       LEFT JOIN ( SELECT to_char(product_incidents.created_at, 'Mon'::text) AS "Month",
              product_incidents.customer_id,
              count(product_incidents.customer_id) AS incidents
             FROM product_incidents
            WHERE ((product_incidents.created_at > (CURRENT_DATE - 'P3M'::interval)) AND (product_incidents.status <> 2))
            GROUP BY (to_char(product_incidents.created_at, 'Mon'::text)), product_incidents.customer_id) b ON ((a."Month" = b."Month")));
  SQL
  create_view "incidents_by_customers_week_views", materialized: true, sql_definition: <<-SQL
      SELECT a.date,
      b.customer_id,
      b.incidents
     FROM (( SELECT (date_trunc('day'::text, dd.dd))::date AS date
             FROM generate_series(((CURRENT_DATE - 7))::timestamp with time zone, ((CURRENT_DATE - 1))::timestamp with time zone, 'P1D'::interval) dd(dd)) a
       LEFT JOIN ( SELECT (product_incidents.created_at)::date AS date,
              product_incidents.customer_id,
              count(product_incidents.customer_id) AS incidents
             FROM product_incidents
            WHERE ((product_incidents.created_at > (CURRENT_DATE - 7)) AND (product_incidents.status <> 2))
            GROUP BY ((product_incidents.created_at)::date), product_incidents.customer_id) b ON ((a.date = b.date)));
  SQL
  create_view "products_by_boxes_one_month_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.box_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 'P1M'::interval)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.box_id, products.code, products.name, product_incidents.product_id
    ORDER BY product_incidents.box_id, (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_boxes_six_month_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.box_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 'P6M'::interval)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.box_id, products.code, products.name, product_incidents.product_id
    ORDER BY product_incidents.box_id, (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_boxes_three_month_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.box_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 'P3M'::interval)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.box_id, products.code, products.name, product_incidents.product_id
    ORDER BY product_incidents.box_id, (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_boxes_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.box_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.box_id, products.code, products.name, product_incidents.product_id
    ORDER BY product_incidents.box_id, (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_boxes_week_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.box_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 7)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.box_id, products.code, products.name, product_incidents.product_id
    ORDER BY product_incidents.box_id, (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_customers_one_month_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.customer_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 'P1M'::interval)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.customer_id, products.code, products.name, product_incidents.product_id
    ORDER BY (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_customers_six_month_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.customer_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 'P6M'::interval)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.customer_id, products.code, products.name, product_incidents.product_id
    ORDER BY (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_customers_three_month_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.customer_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 'P3M'::interval)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.customer_id, products.code, products.name, product_incidents.product_id
    ORDER BY (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_customers_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.customer_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.customer_id, products.code, products.name, product_incidents.product_id
    ORDER BY (sum(product_incidents.quantity)) DESC;
  SQL
  create_view "products_by_customers_week_views", materialized: true, sql_definition: <<-SQL
      SELECT product_incidents.customer_id,
      products.code,
      products.name,
      product_incidents.product_id,
      sum(product_incidents.quantity) AS quantity
     FROM product_incidents,
      products
    WHERE ((products.id = product_incidents.product_id) AND (product_incidents.created_at > (CURRENT_DATE - 7)) AND (product_incidents.status <> 2) AND (products.status <> 2))
    GROUP BY product_incidents.customer_id, products.code, products.name, product_incidents.product_id
    ORDER BY (sum(product_incidents.quantity)) DESC;
  SQL
end

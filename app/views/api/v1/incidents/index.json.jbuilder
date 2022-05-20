# frozen_string_literal: true

json.data @incidents.map do |incident|
  json.id incident.id
  json.user_id incident.user_id
  json.customer_id incident.customer_id
  json.created_on incident.date_time

  json.products incident.product_incidents do |product_incident|
    product = product_incident.product
    box = product_incident.box
    product_box = product.box(box.id)

    json.id product.id
    json.box_code box.code
    json.code product.code
    json.name product.name
    json.description product.description
    json.status product.status
    json.is_expirable product.is_expirable
    json.photo product.photo.url
    json.used product_incident.quantity
    json.left product_box.remaining
    json.threshold product_box.threshold
    json.expiry product_box.expiry
  end
end

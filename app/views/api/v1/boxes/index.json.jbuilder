# frozen_string_literal: true

json.data @boxes.map do |box|
  json.id box.id
  json.code box.code
  json.location box.location
  json.type box.box_type
  json.status box.status

  json.products box.products do |product|
    product_box = product.box(box.id)
    json.id product.id
    json.code product.code
    json.name product.name
    json.description product.description
    json.status product.status
    json.is_expirable product.is_expirable
    json.photo product.photo.url
    json.used product.used(box.id)
    json.left product_box.remaining
    json.threshold product_box.threshold
    json.expiry product_box.expiry
  end
end

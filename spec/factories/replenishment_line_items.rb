# frozen_string_literal: true

FactoryBot.define do
  factory :replenishment_line_item do
    product_name { 'MyString' }
    quantity_before { 1 }
    quantity_after { 1 }
    quantity { 1 }
    expiry_before { '2021-05-17 12:20:35' }
    expiry_after { '2021-05-17 12:20:35' }
    replenishment { nil }
  end
end

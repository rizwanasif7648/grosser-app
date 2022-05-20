# frozen_string_literal: true

FactoryBot.define do
  factory :adjustment do
    expiry_before { '2021-05-28 12:35:10' }
    expiry_after { '2021-05-28 12:35:10' }
    quantity_before { 1 }
    quantity_after { 1 }
    product_name { 'MyString' }
    references { '' }
    references { '' }
    references { '' }
    threshold_before { 1 }
    threshold_after { 1 }
    notes { 'MyText' }
  end
end

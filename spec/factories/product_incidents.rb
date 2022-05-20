# frozen_string_literal: true

# == Schema Information
#
# Table name: product_incidents
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  product_id    :bigint
#  incident_id   :bigint
#  box_id        :bigint
#  quantity      :integer
#  balance       :integer
#  expiry        :datetime
#  status        :integer          default("active")
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :product_incident do
    customer { nil }
    product { nil }
    incident { nil }
    box { nil }
    quantity { 1 }
    balance { 1 }
    expiry { '2020-04-28 14:28:28' }
    status { 1 }
    created_by_id { 1 }
    updateed_by_id { 1 }
  end
end

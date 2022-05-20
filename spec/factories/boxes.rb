# frozen_string_literal: true

# == Schema Information
#
# Table name: boxes
#
#  id            :bigint           not null, primary key
#  code          :string
#  customer_id   :bigint
#  location      :string           not null
#  box_type      :string
#  status        :integer          default("active")
#  min_products  :integer
#  max_products  :integer
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qrcode_url    :string
#  color         :string           default("health-blue")
#
FactoryBot.define do
  factory :box do
    code { '2222' }
    customer { 1 }
    location { 'E3' }
    box_type { 'type1' }
    status { 'active' }
    min_products { 1 }
    max_products { 1 }
    created_by_id { 1 }
    updated_by_id { 1 }
  end
end

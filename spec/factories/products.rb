# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  code          :string
#  name          :string           not null
#  description   :text
#  category      :string
#  brand         :string
#  asset_type    :string
#  is_expirable  :boolean          default(TRUE)
#  photo         :string
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qrcode_url    :string
#
FactoryBot.define do
  factory :product do
    code { '22222' }
    name { 'Test product' }
    description { 'description' }
    category { 'category1' }
    brand { 'brand1' }
    asset_type { 'asset_type_1' }
    is_expirable { false }
    photo_url { 'www.test.com/test/test.png' }
    status { 1 }
    created_by_id { 1 }
    updated_by_id { 1 }
  end
end

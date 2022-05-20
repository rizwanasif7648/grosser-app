# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id             :bigint           not null, primary key
#  code           :string
#  name           :string
#  url            :string
#  email          :string           not null
#  phone          :string
#  street_address :string
#  country        :string
#  state          :string
#  city           :string
#  postcode       :string
#  status         :integer          default("active")
#  industry       :string
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  color          :string           default("health-blue")
#
FactoryBot.define do
  factory :customer do
    code { '22222' }
    name { 'Test customer' }
    url { 'www.test.com' }
    email { 'test@test.com' }
    phone { '033333333' }
    street_address { '34 Block' }
    country { 'Pakistan' }
    state { 'Punjab' }
    city { 'Lahore' }
    postcode { '54000' }
    status { 'active' }
    industry { 'Softwore' }
    created_by_id { 1 }
    updated_by_id { 1 }
  end
end

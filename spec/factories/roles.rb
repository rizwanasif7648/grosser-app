# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  title         :string           not null
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  customer_id   :bigint
#
FactoryBot.define do
  factory :role do
    title { 'test role' }
    status { 'active' }
    customer_id { 1 }
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: lookups
#
#  id         :bigint           not null, primary key
#  category   :integer
#  key        :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :lookup do
    category { 1 }
    key { 'MyString' }
    value { 'MyString' }
  end
end

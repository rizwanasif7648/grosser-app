# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  title             :string
#  body              :string
#  notification_type :integer
#  user_id           :bigint
#  customer_id       :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  read_at           :datetime
#
FactoryBot.define do
  factory :notification do
    title { 'MyString' }
    body { 'MyString' }
    notification_type { 1 }
    user_id { '' }
    customer_id { '' }
  end
end

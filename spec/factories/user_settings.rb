# frozen_string_literal: true

# == Schema Information
#
# Table name: user_settings
#
#  id                :bigint           not null, primary key
#  notification      :string
#  notification_type :integer
#  flag              :boolean
#  user_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :user_setting do
    notification { 'MyString' }
    notification_type { 1 }
    flag { false }
    user_id { '' }
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: incidents
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  user_id       :bigint
#  box_id        :bigint
#  date_time     :datetime
#  status        :integer          default("active")
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :incident do
    customer { nil }
    user { nil }
    box { nil }
    date_time { '2020-04-28 12:37:42' }
    status { 1 }
    created_by_id { 1 }
    updateed_by_id { 1 }
  end
end

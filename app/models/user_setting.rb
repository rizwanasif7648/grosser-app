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
class UserSetting < ApplicationRecord
  belongs_to :user
  enum notification_type: %w[email push]
end

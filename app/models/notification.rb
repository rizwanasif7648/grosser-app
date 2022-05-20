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
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  enum notification_type: %w[email push]

  scope :unread, -> { where(read_at: nil) }

  def read?
    read_at.present?
  end
end

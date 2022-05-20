# frozen_string_literal: true

# == Schema Information
#
# Table name: user_boxes
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  user_id       :bigint
#  box_id        :bigint
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class UserBox < ApplicationRecord
  WHITELIST_ATTRIBUTES = %i[
    id customer_id user_id status created_by_id updated_by_id
  ].freeze

  default_scope do
    where.not(status: 'archived')
  end

  validates :box_id, uniqueness: { scope: [:user_id], message: 'User already added' }

  belongs_to :customer
  belongs_to :user
  belongs_to :box
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true

  enum status: %w[inactive active archived]
end

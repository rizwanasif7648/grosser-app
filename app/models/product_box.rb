# frozen_string_literal: true

# == Schema Information
#
# Table name: product_boxes
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  product_id    :bigint
#  box_id        :bigint
#  status        :integer          default("active")
#  count         :integer
#  threshold     :integer
#  expiry        :datetime
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  remaining     :integer
#
class ProductBox < ApplicationRecord
  WHITELIST_ATTRIBUTES = %i[
    id customer_id product_id count threshold expiry status created_by_id updated_by_id
  ].freeze

  validates :box_id, uniqueness: { scope: [:product_id], message: 'Product already added' }
  validates_numericality_of :threshold, less_than_or_equal_to: :count, greater_than: 0
  belongs_to :customer
  belongs_to :product
  belongs_to :box
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true

  default_scope do
    where.not(status: 'archived')
  end

  enum status: %w[inactive active archived]
  def expire_the_product_box
    box.change_color_to_yellow
    Notifier.notify_users_about_product_expiry(self)
  end

  def product_expiring_soon
    Notifier.notify_users_about_product_expiring_soon(self)
  end

  def check_threshold
    return unless remaining <= threshold

    box.change_color_to_red
    Notifier.notify_users_about_product_threshold(self)
  end
end

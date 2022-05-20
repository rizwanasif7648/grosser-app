# frozen_string_literal: true

# == Schema Information
#
# Table name: product_incidents
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  product_id    :bigint
#  incident_id   :bigint
#  box_id        :bigint
#  quantity      :integer
#  balance       :integer
#  expiry        :datetime
#  status        :integer          default("active")
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ProductIncident < ApplicationRecord
  WHITELIST_ATTRIBUTES = %i[
    id customer_id product_id incident_id box_id quantity
    balance expiry status created_by_id updated_by_id _destroy
  ].freeze

  after_create :set_expiry
  after_create :set_balance

  belongs_to :customer
  belongs_to :product
  belongs_to :incident
  belongs_to :box

  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'

  default_scope do
    where.not(status: 'archived')
  end

  validates :quantity, presence: true, numericality: { greater_than: 0,
                                                       message: 'must be greater than 0' }
  validate :validate_product_count
  validate :validate_product_expiry
  enum status: %w[inactive active archived]

  private

  def set_expiry
    update(expiry: current_product_box.expiry)
  end

  def set_balance
    update(balance: current_product_box.remaining)
    current_product_box.update(remaining: balance - quantity)
  end

  def validate_product_count
    if current_product_box.remaining < quantity
      errors.add(
        :quantity, "of #{product.name} must be less than or equal to current product stock."
      )
      false
    else
      true
    end
  end

  def validate_product_expiry
    return true unless product.is_expirable

    if current_product_box.expiry < Date.today
      errors.add(
        :expiry, "#{product.name} has been expired"
      )
      false
    else
      true
    end
  end

  def current_product_box
    product.product_boxes.find_by_box_id(box_id)
  end
end

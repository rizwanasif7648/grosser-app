# frozen_string_literal: true

class Adjustment < ApplicationRecord
  WHITELIST_ATTRIBUTES = %i[expiry_before expiry_after quantity_before quantity_after
                            product_name customer_id box_id product_id created_by_id
                            threshold_before threshold_after notes].freeze
  belongs_to :customer
  belongs_to :box
  belongs_to :product
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  validates_numericality_of :threshold_after, less_than_or_equal_to: :quantity_after,
                                              greater_than: 0
  after_save :update_product_boxes

  def update_product_boxes
    @product_box = ProductBox.find_by(box_id: box_id, product_id: product_id)
    @product_box&.update!(expiry: expiry_after, threshold: threshold_after,
                          remaining: quantity_after, count: quantity_after)
  end
end

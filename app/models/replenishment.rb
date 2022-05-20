# frozen_string_literal: true

class Replenishment < ApplicationRecord
  include ReplenishmentValidations

  WHITELIST_ATTRIBUTES = [
    :po_no, :po_issuance, :quotation_no, :location, :notes, :added_date,
    :created_by_id, :customer_id, :box_id,
    replenishment_line_items_attributes: ReplenishmentLineItem::WHITELIST_ATTRIBUTES
  ].freeze

  belongs_to :customer
  belongs_to :box
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  has_many :replenishment_line_items, dependent: :destroy
  has_many :uploads, dependent: :destroy
  after_save :update_boxes_product

  accepts_nested_attributes_for :uploads, allow_destroy: true,
                                          reject_if: :all_blank

  accepts_nested_attributes_for :replenishment_line_items, allow_destroy: true,
                                                           reject_if: :all_blank

  def update_boxes_product
    replenishment_line_items.each do |line_item|
      @product_box = ProductBox.find_by(box_id: line_item.box_id, product_id: line_item.product_id)
      @product_box&.update!(expiry: line_item.expiry_after, count: line_item.quantity,
                            remaining: line_item.quantity_after)
    end
  end
end

# frozen_string_literal: true

class ReplenishmentLineItem < ApplicationRecord
  WHITELIST_ATTRIBUTES = %i[
    id product_name quantity_before quantity_after quantity expiry_before expiry_after
    replenishment_id _destroy customer_id box_id product_id
  ].freeze

  belongs_to :replenishment
  belongs_to :customer
  belongs_to :box
  belongs_to :product
end

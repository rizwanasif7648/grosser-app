# frozen_string_literal: true

module ReplenishmentValidations
  extend ActiveSupport::Concern
  included do
    validates :po_no, presence: true
    validates :po_issuance, presence: true
    validates :quotation_no, presence: true
    validates :location, presence: true
    validates :added_date, presence: true
  end
end

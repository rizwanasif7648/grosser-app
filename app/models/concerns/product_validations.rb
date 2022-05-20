# frozen_string_literal: true

module ProductValidations
  extend ActiveSupport::Concern
  included do
    validates :code, presence: true,
                     uniqueness: true,
                     length: { maximum: 20 }

    validates :name, presence: true,
                     uniqueness: true,
                     length: { maximum: 50 }

    validates :description, presence: true,
                            length: { maximum: 70 }

    validates :category, presence: true
    validates :brand, presence: true
    validates :asset_type, presence: true

    validates :status, presence: true
  end
end

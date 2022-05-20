# frozen_string_literal: true

module CustomerValidations
  extend ActiveSupport::Concern
  included do
    validates :name, presence: true,
                     length: { maximum: 70 }

    validates :email, presence: true,
                      uniqueness: true,
                      format: { with: URI::MailTo::EMAIL_REGEXP },
                      length: { maximum: 255 }
    validates :url, presence: false,
                    allow_blank: true,
                    format: { with: URI.regexp(%w[http https]) },
                    length: { maximum: 2000 }

    validates :phone, presence: true,
                      length: { maximum: 15 },
                      format: { with: /\+(?:[0-9] ?){6,14}[0-9]/ }

    validates :street_address, presence: true,
                               length: { maximum: 100 }

    validates :country, presence: true
    validates :state, presence: true
    validates :city, presence: true

    validates :postcode, presence: true,
                         length: { maximum: 15 }
    validates :status, presence: true
  end
end

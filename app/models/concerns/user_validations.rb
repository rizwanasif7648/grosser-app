# frozen_string_literal: true

module UserValidations
  extend ActiveSupport::Concern
  included do
    validates :name, presence: true,
                     length: { maximum: 70 }
    validates_format_of :name, with: /\A[a-zA-Z0-9 ]+\z/

    validates :email, presence: true,
                      format: { with: URI::MailTo::EMAIL_REGEXP },
                      length: { maximum: 255 }

    validates :phone, presence: { message: 'is required' }
    validates :phone, format: { with: /\+(?:[0-9] ?){6,14}[0-9]/,
                                message: 'Invalid! Please enter a valid phone e.g +xxxxxxxxxxxxxx' }
    validates :phone, length: { maximum: 15, message: 'cannot be more than 15 characters long' }

    validates :password, presence: true, on: :create
  end
end

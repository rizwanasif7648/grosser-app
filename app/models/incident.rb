# frozen_string_literal: true

# == Schema Information
#
# Table name: incidents
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  user_id       :bigint
#  box_id        :bigint
#  date_time     :datetime
#  status        :integer          default("active")
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Incident < ApplicationRecord
  WHITELIST_ATTRIBUTES = [
    :customer_id, :user_id, :box_id, :date_time, :status, :created_by_id, :updated_by_id,
    product_incidents_attributes: ProductIncident::WHITELIST_ATTRIBUTES
  ].freeze

  belongs_to :customer
  belongs_to :user
  belongs_to :box
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'

  has_many :product_incidents, dependent: :destroy
  has_many :products, through: :product_incidents

  default_scope do
    where.not(status: 'archived')
  end

  accepts_nested_attributes_for :product_incidents, allow_destroy: true,
                                                    reject_if: :all_blank

  validates :date_time, presence: true
  enum status: %w[inactive active archived]

  after_create :notify_box_users, :check_product_box_threshold

  def notify_box_users
    Notifier.notify_box_users_about_incident(self)
  end

  def check_product_box_threshold
    box.check_product_box_threshold
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id             :bigint           not null, primary key
#  code           :string
#  name           :string
#  url            :string
#  email          :string           not null
#  phone          :string
#  street_address :string
#  country        :string
#  state          :string
#  city           :string
#  postcode       :string
#  status         :integer          default("active")
#  industry       :string
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  color          :string           default("health-blue")
#
class Customer < ApplicationRecord
  include CustomerValidations

  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true
  has_many :roles
  has_many :boxes
  has_many :replenishments
  has_many :users
  has_many :incidents
  has_many :notifications
  has_many :incident_requests

  default_scope do
    where.not(status: 'archived').order('LOWER(name)')
  end

  enum status: %w[inactive active archived]

  after_create :generate_customer_code

  def generate_customer_code
    update(code: format("#{name[0..2].upcase}%.4d", id))
  end

  def change_color_to_yellow
    update(color: 'health-yellow') if color != 'health-red'
  end

  def change_color_to_red
    update(color: 'health-red')
  end
end

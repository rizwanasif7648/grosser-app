# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  title         :string           not null
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  customer_id   :bigint
#
class Role < ApplicationRecord
  WHITELIST_ATTRIBUTES = [
    :title, :status, :customer_id,
    role_permissions_attributes: RolePermission::WHITELIST_ATTRIBUTES
  ].freeze

  default_scope do
    where.not(status: 'archived').order('LOWER(title)')
  end

  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true
  belongs_to :customer
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  after_create :create_role_permissions

  validates :title, presence: true,
                    length: { maximum: 20 },
                    uniqueness: { scope: :customer_id, case_sensitive: false }

  enum status: %w[inactive active archived]

  accepts_nested_attributes_for :role_permissions, allow_destroy: true,
                                                   reject_if: :all_blank

  def accessable_role_permissions
    role_permissions.where('is_readable = :query OR is_createable = :query OR is_updateable = :query
                           OR is_deleteable = :query', query: true)
  end

  private

  def create_role_permissions
    Permission.all.each do |permission|
      RolePermission.where(role_id: id, permission_id: permission.id).first_or_create!
    end
  end
end

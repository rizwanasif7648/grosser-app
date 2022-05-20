# frozen_string_literal: true

# == Schema Information
#
# Table name: permissions
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  status        :integer          default("active")
#  icon          :string
#  path          :string
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Permission < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  validates :name, presence: true, uniqueness: true
  enum status: %w[inactive active]

  def self.authorized?(role_id, permission_name, action)
    Permission.joins(:role_permissions).where(
      "role_id =? AND name =? AND role_permissions.#{action} =?",
      role_id, permission_name, true
    ).exists?
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: role_permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint
#  permission_id :bigint
#  status        :integer          default("active")
#  is_readable   :boolean          default(FALSE)
#  is_createable :boolean          default(FALSE)
#  is_updateable :boolean          default(FALSE)
#  is_deleteable :boolean          default(FALSE)
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class RolePermission < ApplicationRecord
  WHITELIST_ATTRIBUTES = %i[
    id role_id permission_id status is_readable is_createable is_updateable
    is_deleteable created_by_id updated_by_id
  ].freeze

  default_scope { order('created_at') }

  belongs_to :role
  belongs_to :permission
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true

  enum status: %w[inactive active]
end

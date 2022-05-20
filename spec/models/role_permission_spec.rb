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
require 'rails_helper'

RSpec.describe RolePermission, type: :model do
  describe 'associations' do
    it { should belong_to(:permission) }
    it { should belong_to :role }
  end
end

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
require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(20) }

  describe 'associations' do
    it { should have_many(:permissions) }
    it { should have_many :role_permissions }
    it { should belong_to(:customer) }
    it { should accept_nested_attributes_for :role_permissions }
  end
end

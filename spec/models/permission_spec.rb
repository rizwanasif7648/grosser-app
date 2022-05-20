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
require 'rails_helper'

RSpec.describe Permission, type: :model do
  it { should validate_presence_of(:name) }

  describe 'associations' do
    it { should have_many(:roles) }
    it { should have_many :role_permissions }
  end
end

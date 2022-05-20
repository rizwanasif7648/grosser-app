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
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  describe 'associations' do
    it { should belong_to(:created_by).optional }
    it { should belong_to(:updated_by).optional }
    it { should have_many :roles }
    it { should have_many :boxes }
    it { should have_many :users }
    it { should have_many :incident_requests }
  end
end

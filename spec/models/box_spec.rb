# frozen_string_literal: true

# == Schema Information
#
# Table name: boxes
#
#  id            :bigint           not null, primary key
#  code          :string
#  customer_id   :bigint
#  location      :string           not null
#  box_type      :string
#  status        :integer          default("active")
#  min_products  :integer
#  max_products  :integer
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qrcode_url    :string
#  color         :string           default("health-blue")
#
require 'rails_helper'

RSpec.describe Box, type: :model do
  it { should validate_presence_of(:location) }
  it { should define_enum_for(:status).with_values(%i[inactive active archived]) }

  describe 'associations' do
    it { should belong_to(:created_by) }
    it { should belong_to(:updated_by) }
    it { should belong_to(:customer) }
    it { should have_many :user_boxes }
    it { should have_many :product_boxes }
    it { should have_many :products }
    it { should have_many :incidents }
    it { should accept_nested_attributes_for :user_boxes }
    it { should accept_nested_attributes_for :product_boxes }
  end
end

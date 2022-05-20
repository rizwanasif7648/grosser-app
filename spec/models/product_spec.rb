# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  code          :string
#  name          :string           not null
#  description   :text
#  category      :string
#  brand         :string
#  asset_type    :string
#  is_expirable  :boolean          default(TRUE)
#  photo         :string
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qrcode_url    :string
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:asset_type) }

  describe 'associations' do
    it { should belong_to(:created_by) }
    it { should belong_to :updated_by }
    it { should have_many :product_boxes }
    it { should have_many :boxes }
  end
end

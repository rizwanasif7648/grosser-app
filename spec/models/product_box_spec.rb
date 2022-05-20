# frozen_string_literal: true

# == Schema Information
#
# Table name: product_boxes
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  product_id    :bigint
#  box_id        :bigint
#  status        :integer          default("active")
#  count         :integer
#  threshold     :integer
#  expiry        :datetime
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  remaining     :integer
#
require 'rails_helper'

RSpec.describe ProductBox, type: :model do
  it { should define_enum_for(:status).with_values(%i[inactive active archived]) }

  describe 'associations' do
    it { should belong_to :customer }
    it { should belong_to :product }
    it { should belong_to :box }
    it { should belong_to(:created_by).optional }
    it { should belong_to(:updated_by).optional }
  end
end

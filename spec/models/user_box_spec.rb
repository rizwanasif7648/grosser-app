# frozen_string_literal: true

# == Schema Information
#
# Table name: user_boxes
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  user_id       :bigint
#  box_id        :bigint
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe UserBox, type: :model do
  it { should define_enum_for(:status).with_values(%i[inactive active archived]) }

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to :user }
    it { should belong_to :box }
    it { should belong_to(:created_by).optional }
    it { should belong_to(:updated_by).optional }
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: product_incidents
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  product_id    :bigint
#  incident_id   :bigint
#  box_id        :bigint
#  quantity      :integer
#  balance       :integer
#  expiry        :datetime
#  status        :integer          default("active")
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe ProductIncident, type: :model do
  it { should validate_presence_of(:quantity) }
  it { should define_enum_for(:status).with_values(%i[inactive active archived]) }

  describe 'associations' do
    it { should belong_to :customer }
    it { should belong_to :product }
    it { should belong_to :incident }
    it { should belong_to :box }
    it { should belong_to :created_by }
    it { should belong_to :updated_by }
  end
end

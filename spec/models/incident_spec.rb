# frozen_string_literal: true

# == Schema Information
#
# Table name: incidents
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  user_id       :bigint
#  box_id        :bigint
#  date_time     :datetime
#  status        :integer          default("active")
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Incident, type: :model do
  it { should validate_presence_of(:date_time) }
  it { should define_enum_for(:status).with_values(%i[inactive active archived]) }

  describe 'associations' do
    it { should belong_to :customer }
    it { should belong_to :user }
    it { should belong_to :box }
    it { should belong_to(:created_by) }
    it { should belong_to(:updated_by) }
    it { should have_many :product_incidents }
    it { should have_many :products }
    it { should accept_nested_attributes_for :product_incidents }
  end
end

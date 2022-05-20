# frozen_string_literal: true

# == Schema Information
#
# Table name: incident_requests
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  user_id       :bigint
#  image         :string
#  created_by_id :bigint
#  updated_by_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe IncidentRequest, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to :customer }
  end
end

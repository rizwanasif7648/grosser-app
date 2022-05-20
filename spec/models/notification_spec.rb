# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  title             :string
#  body              :string
#  notification_type :integer
#  user_id           :bigint
#  customer_id       :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  read_at           :datetime
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:customer) }
  end
end

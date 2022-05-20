# frozen_string_literal: true

# == Schema Information
#
# Table name: user_settings
#
#  id                :bigint           not null, primary key
#  notification      :string
#  notification_type :integer
#  flag              :boolean
#  user_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe UserSetting, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end
end

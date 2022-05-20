# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  name                   :string
#  phone                  :string
#  profile_picture        :string
#  status                 :integer          default("active")
#  is_web_user            :boolean          default(TRUE)
#  is_superuser           :boolean          default(FALSE)
#  created_by_id          :integer
#  updated_by_id          :integer
#  role_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  customer_id            :bigint
#  color                  :string           default("health-blue")
#  player_id              :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:password) }

  describe 'associations' do
    it { should belong_to(:role) }
    it { should belong_to :customer }
    it { should have_many :user_boxes }
    it { should have_many :boxes }
    it { should have_many :user_settings }
    it { should have_many :incident_requests }
  end
end

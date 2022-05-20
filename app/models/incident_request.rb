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
class IncidentRequest < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'

  mount_uploader :image, PictureUploader
end

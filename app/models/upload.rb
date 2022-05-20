# frozen_string_literal: true

class Upload < ApplicationRecord
  belongs_to :replenishment, optional: true

  mount_uploader :photo, PictureUploader
end

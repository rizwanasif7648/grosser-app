# frozen_string_literal: true

# Parent Abstract Model for all the models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.status_options
    statuses = try(:statuses)
    statuses ? statuses.except(:archived) : {}
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: lookups
#
#  id         :bigint           not null, primary key
#  category   :integer
#  key        :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Lookup < ApplicationRecord
  default_scope { order('key') }

  enum category: %w[industry category brand asset_type box_type]
end

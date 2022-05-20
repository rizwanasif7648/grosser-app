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
require 'rails_helper'

RSpec.describe Lookup, type: :model do
  it {
    should define_enum_for(:category).with_values(%i[industry category brand
                                                     asset_type box_type])
  }
end

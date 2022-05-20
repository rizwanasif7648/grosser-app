# frozen_string_literal: true

# == Schema Information
#
# Table name: supports
#
#  id           :bigint           not null, primary key
#  to           :string
#  from         :string
#  title        :string
#  body_message :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Support, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

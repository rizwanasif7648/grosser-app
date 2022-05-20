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
class Support < ApplicationRecord
end

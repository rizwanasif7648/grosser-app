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
FactoryBot.define do
  factory :support do
    to { 'to@email.com' }
    from { 'from@email.com' }
    title { 'Title of Support Ticket' }
    body_message { 'Message of Support' }
  end
end

# frozen_string_literal: true

json.data @notifications.map do |notification|
  json.id notification.id
  json.title notification.title
  json.body notification.body
  json.user_id notification.user_id
  json.created_on notification.created_at
end

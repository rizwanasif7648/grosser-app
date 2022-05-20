# frozen_string_literal: true

json.data @user_settings.group_by(&:notification_type).each do |type, settings_group|
  json.set! type do
    json.array! settings_group.sort_by(&:id).each do |obj|
      json.key obj.notification
      json.flag obj.flag
    end
  end
end

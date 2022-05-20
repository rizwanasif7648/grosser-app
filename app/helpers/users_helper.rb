# frozen_string_literal: true

# Customer Helper for shared functions for Customers Module
module UsersHelper
  def user_boxes(user)
    user.boxes.size
  end

  def user_boxes_locations(user)
    user.boxes.map(&:location).join(', ')
  end

  def user_notifications_count
    current_user.notifications.unread.email.size
  end

  def profile_picture_identifier(user, form)
    form.object.persisted? ? user.profile_picture.identifier : ''
  end
end

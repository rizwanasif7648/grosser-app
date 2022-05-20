# frozen_string_literal: true

module Notifier
  class << self
    def notify_box_users_about_incident(incident)
      box = incident.box
      users_to_notify = box.users.mobile
      title = 'Incident Alert'
      message = "A new incident has been created against box #{box.code} by
#{incident.created_by.name} on #{incident.created_at}."
      users_to_notify.each do |user|
        if user.receiving_notification?('push', 'create_incident')
          Onesignal.notify_box_users_about_incident(user, title, message)
        end
        if user.receiving_notification?('email', 'create_incident')
          UserMailer.new_incident_created(incident, user, box).deliver_later
        end
      end

      web_users = box.users.web
      web_users.each do |user|
        if user.receiving_notification?('push', 'create_incident')
          Notification.create!(title: title, body: message, user_id: user.id,
                               customer_id: user.customer_id, notification_type: 'email')
        end
        if user.receiving_notification?('email', 'create_incident')
          UserMailer.new_incident_created(incident, user, box).deliver_later
        end
      end
    end

    def notify_users_about_product_expiry(product_box)
      box = product_box.box
      users_to_notify = box.users.mobile
      title = 'Product Expiry Alert'
      message = "Our record indicates that the following products have expired in
the box #{box.code},#{product_box.product.name}"
      users_to_notify.each do |user|
        if user.receiving_notification?('push', 'product_expiry')
          Onesignal.notify_users_about_product_expiry(user, title, message)
        end
        if user.receiving_notification?('email', 'product_expiry')
          UserMailer.product_expired(user, box, product_box).deliver_later
        end
      end

      web_users = box.users.web
      web_users.each do |user|
        if user.receiving_notification?('push', 'product_expiry')
          Notification.create!(title: title, body: message, user_id: user.id,
                               customer_id: user.customer_id, notification_type: 'email')
        end
        if user.receiving_notification?('email', 'product_expiry')
          UserMailer.product_expired(user, box, product_box).deliver_later
        end
      end
    end

    def notify_users_about_product_threshold(product_box)
      box = product_box.box
      users_to_notify = box.users.mobile
      title = 'Low Stock Alert'
      message = "Our record indicates that the following products have low stock levels in
the box #{box.code}, #{product_box.product.name}"
      users_to_notify.each do |user|
        if user.receiving_notification?('push', 'resupply_point')
          Onesignal.notify_users_about_product_threshold(user, title, message)
        end
        if user.receiving_notification?('email', 'resupply_point')
          UserMailer.product_threshold(user, box, product_box).deliver_later
        end
      end

      web_users = box.users.web
      web_users.each do |user|
        if user.receiving_notification?('push', 'resupply_point')
          Notification.create!(title: title, body: message, user_id: user.id,
                               customer_id: user.customer_id, notification_type: 'email')
        end
        if user.receiving_notification?('email', 'resupply_point')
          UserMailer.product_threshold(user, box, product_box).deliver_later
        end
      end
    end

    def _logbook_users(customer)
      User.joins(role: :permissions)
          .where("roles.customer_id = #{customer.id} and
                  permissions.name='LogBook'
                  and users.is_web_user = true")
    end

    def notify_users_about_product_expiring_soon(product_box)
      box = product_box.box
      users_to_notify = box.users.mobile
      title = 'Product Expiry Alert'
      message = "Our record indicates that the following products are expiring soon in
the box #{box.code},#{product_box.product.name}"
      users_to_notify.each do |user|
        if user.receiving_notification?('push', 'product_expiry')
          Onesignal.notify_users_about_product_expiry(user, title, message)
        end
        if user.receiving_notification?('email', 'product_expiry')
          UserMailer.product_expiring_soon(user, box, product_box).deliver_later
        end
      end

      web_users = box.users.web
      web_users.each do |user|
        if user.receiving_notification?('push', 'product_expiry')
          Notification.create!(title: title, body: message, user_id: user.id,
                               customer_id: user.customer_id, notification_type: 'email')
        end
        if user.receiving_notification?('email', 'product_expiry')
          UserMailer.product_expiring_soon(user, box, product_box).deliver_later
        end
      end
    end
  end
end

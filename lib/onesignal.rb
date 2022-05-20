# frozen_string_literal: true

require 'one_signal'

class Onesignal
  class << self
    def create_notification(title, message, receiver, type)
      puts api_key = ENV.fetch('ONESIGNAL_API_KEY', '')
      puts user_auth_key = ENV.fetch('ONESIGNAL_AUTH_KEY', '')
      puts app_id = ENV.fetch('ONESIGNAL_APP_ID', '')

      puts '====================================================='
      # configure OneSignal
      OneSignal::OneSignal.api_key = api_key
      OneSignal::OneSignal.user_auth_key = user_auth_key

      # notify the player (this will fail because we haven't configured the app yet)

      params = {
        app_id: app_id,
        contents: {
          en: message
        },
        headings: {
          en: title
        },
        data: {
          type: type
        },
        include_player_ids: [receiver.player_id]
      }

      begin
        response = OneSignal::Notification.create(params: params)
        Notification.create(title: title, body: message, user_id: receiver.id,
                            customer_id: receiver.customer_id, notification_type: 'push')
        puts JSON.parse(response.body)
      rescue OneSignal::OneSignalError => e
        puts "OneSignal Exception Message #{e.message}"
        puts "OneSignal Exception http body #{e.http_body}"
      end
    end

    def notify_box_users_about_incident(user, title, message)
      create_notification(title, message, user, 'INCIDENT_CREATED') if user.player_id.present?
    end

    def notify_users_about_product_expiry(user, title, message)
      create_notification(title, message, user, 'PRODUCT_EXPIRY') if user.player_id.present?
    end

    def notify_users_about_product_threshold(user, title, message)
      create_notification(title, message, user, 'PRODUCT_TRESHOLD') if user.player_id.present?
    end
  end
end

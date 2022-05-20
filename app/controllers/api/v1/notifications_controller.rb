# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApiApplicationController
      before_action :authenticate_request

      api :GET, '/v1/notifications', 'Current User notifications List'
      error 401, 'If access_token is missing in headers.'
      description 'Current User notifications List'
      def index
        @notifications = @current_user.notifications.push
        render 'index.json.jbuilder'
      end
    end
  end
end

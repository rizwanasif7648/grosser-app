# frozen_string_literal: true

module Api
  module V1
    class SettingsController < ApiApplicationController
      before_action :authenticate_request

      def_param_group :settings_params do
        param :email, Array, desc: 'Email Hash', required: true
        param :push, Array, desc: 'Push hash', required: true
      end
      api :POST, '/v1/settings', 'Update User Settings'
      error 401, 'If access_token is missing in headers.'
      description 'Update email/push notifications settings'
      param_group :settings_params
      def update
        params[:email].each_with_index do |obj, _index|
          @current_user.user_settings.where(notification: obj[:key], notification_type: 'email')
                       .update(flag: obj[:flag])
        end
        params[:push].each_with_index do |obj, _index|
          @current_user.user_settings.where(notification: obj[:key], notification_type: 'push')
                       .update(flag: obj[:flag])
        end
        @user_settings = @current_user.user_settings
        render 'index.json.jbuilder'
      end

      api :GET, '/v1/settings', 'Current User Settings List'
      error 401, 'If access_token is missing in headers.'
      description 'Current User Settings List'
      def index
        @user_settings = @current_user.user_settings
        render 'index.json.jbuilder'
      end
    end
  end
end

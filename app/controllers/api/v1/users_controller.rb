# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiApplicationController
      include UsersConcerns
      skip_before_action :authenticate_request, only: %i[login forget_password]
      before_action :set_user, :validate_user_and_customer, :validate_user_type, only: [:login]

      def_param_group :login do
        param :email, String, desc: 'Email', required: true
        param :password, String, desc: 'Password', required: true
      end
      api :POST, '/v1/login', 'Returns access_token for api access'
      param_group :login
      error 401, 'If email/password is incorrect.'
      error 400, 'If email/password is not present.'
      error 422, 'If Customer and User is not active.'
      error 422, 'If Mobile Type User is not present.'
      description 'Get access_token for api access'
      def login
        authenticate params[:email], params[:password], 'Login Successful'
      end

      def_param_group :change_password do
        param :user_id, String, desc: 'User id', required: true
        param :old_password, String, desc: 'Old Password', required: true
        param :new_password, String, desc: 'New Password', required: true
        param :confirm_password, String, desc: 'Confirm Password', required: true
      end
      api :POST, '/v1/change_password', "Change user's password"
      param_group :change_password
      error 401, 'If old_password/new_password is incorrect.'
      error 400, 'If old_password/new_password is not present.'
      description 'Update Password'
      def change_password
        update_password params
      end

      def_param_group :update_profile do
        param :name, String, desc: 'User Name', required: true
        param :profile_picture, String, desc: 'Profile Picture', required: true
      end
      api :PUT, '/v1/update_profile', 'Update User Profile'
      param_group :update_profile
      error 401, 'If access_token is missing in headers.'
      error 400, 'If name, profie picture is not present.'
      description 'Update User Profile'
      def update_profile
        unless update_user_profile params
          return render json: { message: 'Your Profile has not been updated', status: 422 }
        end

        render json: { message: 'Your Profile has successfully been updated', user: @current_user,
                       status: 200 }
      end

      def_param_group :forget_password do
        param :email, String, desc: 'Email', required: true
      end
      api :POST, '/v1/forget_password', 'Forget password'
      param_group :forget_password
      error 401, 'Email is incorrect.'
      error 404, 'Email is not present.'
      description 'Forget Password'
      def forget_password
        forget_password_configuration params
      end

      def_param_group :player_id_params do
        param :player_id, String, desc: 'Device ID for push notification', required: true
      end
      api :POST, '/v1/update_player_id', 'Update player ID'
      param_group :player_id_params
      error 401, "If access_token is missing in headers. // Authorization=Bearer 'access_token'"
      error 422, 'Player ID update failed'
      description 'Update player ID'
      def update_player_id
        respond_to do |format|
          if @current_user.update(player_id: params[:player_id])
            format.json do
              render json: { message: 'Player ID updated successfully', user: @current_user },
                     status: 200
            end

          else
            format.json do
              render json: { message: 'Player ID update failed.' },
                     status: 422
            end
          end
        end
      end
    end
  end
end

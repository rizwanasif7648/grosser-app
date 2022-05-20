# frozen_string_literal: true

ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :name, :phone, :profile_picture, :status, :is_web_user,
                :is_superuser, :created_by_id, :updated_by_id, :role_id, :encrypted_password,
                :reset_password_token, :reset_password_sent_at, :remember_created_at,
                :customer_id, :color, :player_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :name, :phone, :profile_picture, :status, :is_web_user,
  #                :is_superuser, :created_by_id, :updated_by_id, :role_id, :encrypted_password,
  #                :reset_password_token, :reset_password_sent_at, :remember_created_at,
  #                :customer_id, :color, :player_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

# frozen_string_literal: true

ActiveAdmin.register Notification do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :body, :notification_type, :user_id, :customer_id, :read_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :notification_type, :user_id, :customer_id, :read_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

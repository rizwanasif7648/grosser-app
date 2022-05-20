# frozen_string_literal: true

ActiveAdmin.register IncidentRequest do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :customer_id, :user_id, :image, :created_by_id, :updated_by_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_id, :user_id, :image, :created_by_id, :updated_by_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

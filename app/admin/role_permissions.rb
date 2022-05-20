# frozen_string_literal: true

ActiveAdmin.register RolePermission do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :role_id, :permission_id, :status, :is_readable, :is_createable,
                :is_updateable, :is_deleteable, :created_by_id, :updated_by_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:role_id, :permission_id, :status, :is_readable, :is_createable,
  #                :is_updateable, :is_deleteable, :created_by_id, :updated_by_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

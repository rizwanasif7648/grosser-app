# frozen_string_literal: true

ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :code, :name, :description, :category, :brand, :asset_type,
                :is_expirable, :photo, :status, :created_by_id, :updated_by_id, :qrcode_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :name, :description, :category, :brand, :asset_type,
  #                :is_expirable, :photo, :status, :created_by_id, :updated_by_id, :qrcode_url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

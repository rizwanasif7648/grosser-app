# frozen_string_literal: true

ActiveAdmin.register Box do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :code, :customer_id, :location, :box_type, :status, :min_products,
                :max_products, :created_by_id, :updated_by_id, :qrcode_url, :color
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :customer_id, :location, :box_type, :status, :min_products,
  #                :max_products, :created_by_id, :updated_by_id, :qrcode_url, :color]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

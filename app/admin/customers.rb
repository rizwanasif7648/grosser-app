# frozen_string_literal: true

ActiveAdmin.register Customer do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :code, :name, :url, :email, :phone, :street_address, :country,
                :state, :city, :postcode, :status, :industry, :created_by_id,
                :updated_by_id, :color
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :name, :url, :email, :phone, :street_address, :country,
  #                :state, :city, :postcode, :status, :industry, :created_by_id,
  #                :updated_by_id, :color]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end

# frozen_string_literal: true

ActiveAdmin.register Lookup do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :category, :key, :value
  #
  # or
  #
  # permit_params do
  #   permitted = [:category, :key, :value]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #
  scope 'Industry', :industry
  scope 'Category', :category
  scope 'Brand', :brand
  scope 'Asset Type', :asset_type
  scope 'Box Type', :box_type
end

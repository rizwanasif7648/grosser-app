# frozen_string_literal: true

# Boxes Helper for shared functions for Boxes Module
module BoxesHelper
  def mobile_user
    User.where(customer_id: @box.customer).possible_users_list_for_box(@box).active.order(:name)
  end

  def box_types
    Lookup.box_type
  end

  def box_incidents(box)
    incidents = box.incidents.order(created_at: :desc)
    incidents ||= []
    incidents
  end

  def possible_box_products(box)
    Product.active.possible_products_list_for_box(box).order_by_name
  end
end

# frozen_string_literal: true

# Customer Helper for shared functions for Customers Module
module CustomersHelper
  def countries
    sorted_countries = sort_hash(CS.countries)
    sorted_countries.map { |k, v| [v.humanize.capitalize, k] }
  end

  def industries
    Lookup.industry
  end

  def customers
    if accessable?('Customers', 'is_readable')
      Customer.active
    else
      [current_user.customer]
    end
  end

  def customer_products(box)
    box ? box.products : []
  end

  def customer_boxes_list(customer)
    customer.boxes
  end

  def sort_hash(hash)
    hash&.sort_by { |_k, v| v }
  end

  def customer_boxes(customer)
    customer.boxes.size
  end

  def current_box
    @box ? @box.id : []
  end

  def current_product
    @product ? @product.id : []
  end
end

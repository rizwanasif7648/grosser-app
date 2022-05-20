# frozen_string_literal: true

# Product Helper for shared functions for Products Module
module ProductsHelper
  def categories
    Lookup.category
  end

  def brands
    Lookup.brand
  end

  def asset_types
    Lookup.asset_type
  end

  def customers
    if accessable?('Customers', 'is_readable')
      Customer.active
    else
      [current_user.customer]
    end
  end

  def product_picture_identifier(product, form)
    form.object.persisted? ? product.photo.identifier : ''
  end
end

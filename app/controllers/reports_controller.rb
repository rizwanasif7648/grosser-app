# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[index]

  def index; end

  def medicine_report
    @customer = current_customer

    @top_products = Product.joins(:boxes).where('boxes.customer_id = ?', @customer.id)
                           .uniq
                           .map { |p| [p.id, p.name, p.product_boxes.sum('product_boxes.count')] }
                           .sort_by { |_id, _name, count| count }.reverse
    top_product_ids = @top_products.map { |prod| prod[0] }

    @top_boxes = Box.joins(:product_boxes).where('product_boxes.product_id in (?)', top_product_ids)
                    .uniq
                    .map { |box| [box.id, box.code, box.product_boxes.sum(:count)] }
                    .sort_by { |_id, _ode, count| count } .reverse.take(6)
  end
end

# frozen_string_literal: true

# Dashboard controller dashboard page
class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[index]
  include CustomersHelper
  include DashboardConcerns
  def index
    authorize [current_user, 'Dashboard'], policy_class: ApplicationPolicy
    @customer = current_customer
    @total_boxes = boxes(@customer, 'health-blue') ? boxes(@customer, 'health-blue').count : 0
    @red_boxes = boxes(@customer, 'health-red') ? boxes(@customer, 'health-red').count : 0
    @yellow_boxes = boxes(@customer, 'health-yellow') ? boxes(@customer, 'health-yellow').count : 0

    @consumed_products = ProductsByCustomersView.where(customer_id: @customer.id)
    consumed_products_list(@consumed_products)
    incidents_per_boxes(IncidentsByCustomersWeekView, @customer.id, 'date')
    boxes_in_red(BoxesInRedWeekView, @customer.id, 'date')

    return unless @customer.boxes.present?

    @products_by_boxes = ProductsByBoxesView.where(box_id: @customer.boxes.first.id)
    consumed_products_by_boxes(@products_by_boxes)
  end

  def boxes_in_red_zone
    authorize [current_user, 'Dashboard'], :index?, policy_class: ApplicationPolicy
    customer_id = params[:customer_id] if params[:customer_id].present?
    customer_id ||= current_user.customer.id
    duration = params[:duration]
    red_boxes(duration, customer_id)
  end

  def incidents_by_boxes
    authorize [current_user, 'Dashboard'], :index?, policy_class: ApplicationPolicy
    customer_id = params[:customer_id] if params[:customer_id].present?
    customer_id ||= current_user.customer.id
    duration = params[:duration]
    incidents_boxes(duration, customer_id)
  end

  def consumed_products_by_box
    authorize [current_user, 'Dashboard'], :index?, policy_class: ApplicationPolicy
    products_by_boxes = ProductsByBoxesView.where(box_id: params[:box_id])
    products_by_box = consumed_products_table(products_by_boxes)
    render status: :ok, json: { data: products_by_box }
  end

  def consumed_products_by_duration
    authorize [current_user, 'Dashboard'], :index?, policy_class: ApplicationPolicy
    customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    customer ||= current_user.customer
    duration = params[:duration]
    consumed_products_by_date_duration(duration, customer)
  end

  def consumed_products_boxes_by_duration
    authorize [current_user, 'Dashboard'], :index?, policy_class: ApplicationPolicy
    duration = params[:duration]
    box_id = params[:box_id]
    consumed_products_boxes_by_date_duration(duration, box_id)
  end
end

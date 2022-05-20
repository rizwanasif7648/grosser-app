# frozen_string_literal: true

class AdjustmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new index]

  # GET /adjustments
  def index
    authorize [current_user, 'Adjustment'], policy_class: ApplicationPolicy
    @customer = current_customer
    @adjustments = @customer ? Adjustment.where(customer_id: @customer.id) : []
    box_adjustment
    product_adjustment
    @adjustments.order(created_at: :desc)
  end

  def create
    authorize [current_user, 'Adjustment'], policy_class: ApplicationPolicy
    @adjustment = Adjustment.new(adjustment_params)
    if @adjustment.save
      respond_to do |format|
        format.js
      end
    else
      @errors_messages = @adjustment.errors.full_messages
      respond_to do |format|
        format.js do
          render  template: 'adjustments/error_message',
                  layout: false,
                  locals: { errors_messages: @errors_messages }
        end
      end
    end
  end

  private

  def adjustment_params
    params.permit(Adjustment::WHITELIST_ATTRIBUTES)
  end

  def box_adjustment
    return unless params[:box_id].present?

    @box = Box.find(params[:box_id])
    @adjustments = Adjustment.where(customer_id: @customer.id, box_id: @box.id)
  end

  def product_adjustment
    return unless params[:product_id].present?

    @product = Product.find(params[:product_id])
    @adjustments = Adjustment.where(customer_id: @customer.id, box_id: @box.id,
                                    product_id: @product.id)
  end
end

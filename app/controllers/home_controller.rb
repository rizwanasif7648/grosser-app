# frozen_string_literal: true

# Home controller main page
class HomeController < ApplicationController
  before_action :authenticate_user!
  include CustomersHelper

  def index; end

  def states
    states = CS.states(params[:country])
    states = sort_hash(states)
    render status: :ok, json: { states: states.to_h }
  end

  def cities
    cities = CS.cities(params[:state], params[:country])
    cities = sort_hash(cities)
    render status: :ok, json: { cities: cities }
  end

  def users_by_customer
    @customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    @users = if params[:type] == 'mobile'
               @customer ? @customer.users.active.where(is_web_user: false).pluck(:id, :name) : []
             else
               @customer ? @customer.users.active.pluck(:id, :name) : []
             end
    render layout: false
  end

  def boxes_by_user
    @user = User.find(params[:user_id]) if params[:user_id].present?
    @boxes = @user ? @user.boxes.active.pluck(:id, :code) : []
    render layout: false
  end

  def products_by_box
    @box = Box.find(params[:box_id]) if params[:box_id].present?
    @products = if @box
                  @box.active_product_boxes_for_incident
                      .pluck(:'products.id', :'products.name', :expiry)
                else
                  []
                end
    render layout: false
  end

  def boxes_by_customer
    @customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    @boxes = @customer ? @customer.boxes.active.pluck(:id, :code) : []
    render layout: false
  end

  def location_by_box
    @box = Box.find(params[:box_id]) if params[:box_id].present?
    @location = @box ? @box.location : ''
    render status: :ok, json: @location
  end
end

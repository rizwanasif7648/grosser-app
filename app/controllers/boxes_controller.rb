# frozen_string_literal: true

class BoxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new edit index]
  before_action :set_box, only: %i[show edit update destroy user_box_archive product_box_archive
                                   create_user_box create_product_box fetch_box search_product_box
                                   qrcode_url box_adjustment]
  before_action :set_user, only: %i[user_box_archive create_user_box]
  before_action :set_product, only: %i[product_box_archive create_product_box box_adjustment]

  # GET /boxes
  def index
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    @customer = current_customer
    @boxes = @customer ? @customer.boxes.order(created_at: :desc) : []
  end

  # GET /boxes/1
  def show
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @box)
  end

  # GET /boxes/new
  def new
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    @box = Box.new
    @box.user_boxes.build
  end

  # GET /boxes/1/edit
  def edit
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @box)
  end

  # POST /boxes
  def create
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    @box = Box.new(box_params)
    @box.created_by = current_user
    @box.updated_by = current_user
    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /boxes/1
  def update
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    @box.updated_by = current_user
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_to boxes_url, notice: 'Box was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /boxes/1
  def destroy
    authorize [current_user, 'Boxes'], policy_class: ApplicationPolicy
    @box.archived!
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Box was successfully destroyed.' }
    end
  end

  def user_box_archive
    authorize [current_user, 'Boxes'], :destroy?, policy_class: ApplicationPolicy
    @box.user_boxes.find_by(user_id: @user.id).destroy!
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'User was successfully destroyed.' }
    end
  end

  def product_box_archive
    authorize [current_user, 'Boxes'], :destroy?, policy_class: ApplicationPolicy
    @box.product_boxes.find_by(product_id: @product.id).destroy!
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Product was successfully destroyed.' }
    end
  end

  def fetch_box; end

  def box_adjustment
    @product_box = ProductBox.find_by(product_id: params[:product_id], box_id: params[:id])
  end

  def create_user_box
    authorize [current_user, 'Boxes'], :create?, policy_class: ApplicationPolicy
    @user_box = @box.user_boxes.new(customer_id: params[:customer_id])
    @user_box.user = @user
    @user_box.created_by = current_user
    @user_box.updated_by = current_user
    if @user_box.save
      respond_to do |format|
        format.js { render js: 'window.top.location.reload(true);' }
      end
    else
      @errors_messages = @user_box.errors.full_messages
      respond_to do |format|
        format.js do
          render  template: 'boxes/error_message.js.erb',
                  layout: false,
                  locals: { errors_messages: @errors_messages }
        end
      end
    end
  end

  def create_product_box
    authorize [current_user, 'Boxes'], :create?, policy_class: ApplicationPolicy
    @product_box = @box.product_boxes.new(customer_id: params[:customer_id],
                                          count: params[:count], expiry: params[:expiry],
                                          threshold: params[:threshold])
    @product_box.remaining = @product_box.count
    @product_box.product = @product
    @product_box.created_by = current_user
    @product_box.updated_by = current_user
    if @product_box.save
      respond_to do |format|
        format.js
      end
    else
      @errors_messages = @product_box.errors.full_messages
      respond_to do |format|
        format.js do
          render  template: 'boxes/error_message.js.erb',
                  layout: false,
                  locals: { errors_messages: @errors_messages }
        end
      end
    end
  end

  def qrcode_url
    respond_to do |format|
      format.json { render json: @box.qrcode_url.url }
    end
  end

  def search_product_box
    like = params['search'].concat('%')
    product_boxes = @box.active_product_boxes_for_incident
                        .where('lower (products.name) LIKE lower(?)', like).includes(:product)
    list = if product_boxes.present?
             product_boxes.map do |u|
               Hash[id: u.product.id, label: u.product.name, box_id: u.box.id, box_code: u.box.code,
                    photo: u.product.photo, expiry: u.expiry&.strftime('%d/%m/%Y'),
                    qunatity_before: u.remaining]
             end
           else
             Hash[label: 'No Result Found']
           end
    render json: list
  end

  def product_boxes_threshold
    @product_box = ProductBox.find_by(box_id: params[:box_id], product_id: params[:product_id])
    render json: { threshold: @product_box.threshold, status: 200 }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_box
    @box = Box.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  # Only allow a list of trusted parameters through.
  def box_params
    params.require(:box).permit(Box::WHITELIST_ATTRIBUTES)
  end
end

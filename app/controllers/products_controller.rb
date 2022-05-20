# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new edit index]
  before_action :set_product, only: %i[show edit update destroy qrcode_url]
  before_action :sanitize_params, only: %i[create]

  # GET /products
  def index
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
    @products = Product.all.order(created_at: :desc)
  end

  # GET /products/1
  def show
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
  end

  # GET /products/new
  def new
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
  end

  # POST /products
  def create
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
    @product = Product.new(product_params)
    @product.status = params[:product][:status]
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def sanitize_params
    params[:product][:created_by_id] = current_user.id
    params[:product][:updated_by_id] = current_user.id
  end

  # PATCH/PUT /products/1
  def update
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
    respond_to do |format|
      if @product.update(product_update_params)
        @product.update(updated_by_id: current_user.id)
        format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  def destroy
    authorize [current_user, 'Products'], policy_class: ApplicationPolicy
    @product.archived!
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  def qrcode_url
    respond_to do |format|
      format.json { render json: @product.qrcode_url.url }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:code, :name, :description, :category,
                                    :brand, :asset_type, :is_expirable, :photo,
                                    :status, :created_by_id, :updated_by_id)
  end

  def product_update_params
    params.require(:product).permit(:name, :description, :category,
                                    :brand, :asset_type, :is_expirable, :photo,
                                    :status)
  end
end

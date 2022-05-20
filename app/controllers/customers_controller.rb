# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new edit index]
  before_action :set_customer, only: %i[show edit update destroy roles]

  # GET /customers
  def index
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
    @customers = Customer.all
  end

  # GET /customers/1
  def show
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
  end

  # GET /customers/new
  def new
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
  end

  # POST /customers
  def create
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
    @customer = Customer.new(customer_params)
    @customer.created_by_id = current_user.id
    @customer.updated_by_id = current_user.id
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: 'Customer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /customers/1
  def update
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
    respond_to do |format|
      if @customer.update(customer_update_params)
        @customer.updated_by_id = current_user.id
        @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /customers/1
  def destroy
    authorize [current_user, 'Customers'], policy_class: ApplicationPolicy
    @customer.archived!
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
    end
  end

  def roles
    roles = @customer.roles
    render status: :ok, json: { roles: roles }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find_by!(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:name, :url, :email, :phone, :street_address, :country,
                                     :state, :city, :postcode, :status, :industry)
  end

  def customer_update_params
    params.require(:customer).permit(:name, :url, :phone, :street_address, :country,
                                     :state, :city, :postcode, :status, :industry)
  end
end

# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new edit index]
  before_action :set_role, only: %i[show edit update destroy]

  # GET /roles
  def index
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    @customer = current_customer
    @roles = @customer ? @customer.roles : []
  end

  # GET /roles/1
  def show
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @role)
  end

  # GET /roles/new
  def new
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    @role = Role.new
    new_role_permissions(@role)
  end

  # GET /roles/1/edit
  def edit
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @role)
  end

  # POST /roles
  def create
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    @role = Role.new(role_params)
    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_url, notice: 'Role was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /roles/1
  def update
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /roles/1
  def destroy
    authorize [current_user, 'Roles & Permissions'], policy_class: ApplicationPolicy
    @role.archived!
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  def new_role_permissions(role)
    Permission.all.each do |permission|
      role.role_permissions << RolePermission.new(role: role, permission_id: permission.id)
    end
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(Role::WHITELIST_ATTRIBUTES)
  end
end

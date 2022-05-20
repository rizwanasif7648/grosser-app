# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_breadcrumb, only: %i[new edit index]
  before_action :authenticate_user!

  # GET /users
  def index
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    @customer = current_customer
    @users = @customer ? @customer.users.order(created_at: :desc) : []
  end

  # GET /users/1
  def show
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @user)
  end

  # GET /users/new
  def new
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @user)
  end

  # POST /users
  def create
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    respond_to do |format|
      if @user.update(user_update_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    authorize [current_user, 'Users'], policy_class: ApplicationPolicy
    @user.archived!
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  def change_password
    authorize [current_user, 'Users'], :update?, policy_class: ApplicationPolicy
    @user = current_user
    respond_to do |format|
      unless @user.update_with_password(params[:user])
        format.html do
          redirect_to edit_password_users_path, alert: 'Your Current password is Invalid'
        end
      end

      format.html { redirect_to root_path, notice: 'Your Password has successfully been updated' }
    end
  end

  def edit_password
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    authorize [current_user, 'Users'], :update?, policy_class: ApplicationPolicy
    @user = current_user
    respond_to do |format|
      if @user.update(user_profile_params)
        format.html { redirect_to @user, notice: 'User Profile was successfully updated.' }
      else
        format.html do
          redirect_to edit_profile_users_path, alert: @user.errors.full_messages.to_sentence
        end
      end
    end
  end

  def user_notifications
    @notifications = current_user.notifications.email.limit(10).order(created_at: :desc)
    # render status: :ok, json: { notifications: notifications }
  end

  def mark_notification_as_read
    unread_notifications = current_user.notifications.unread.email
    if unread_notifications.present?
      unread_notifications.update_all(read_at: Time.now)
      render status: :ok, json: { message: 'Successfully updated the notifications' }
    else
      render status: :not_found, json: { message: 'No unread notification found' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :name, :phone, :profile_picture, :status,
                                 :is_web_user, :customer_id, :role_id)
  end

  def user_update_params
    params.require(:user).permit(:password, :phone, :profile_picture, :status,
                                 :is_web_user, :customer_id, :role_id)
  end

  def user_profile_params
    params.require(:user).permit(:name, :phone, :profile_picture)
  end
end

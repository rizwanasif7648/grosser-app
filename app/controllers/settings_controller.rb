# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[index]
  # GET /settings
  def index
    @user = current_user
    @settings = current_user.user_settings
  end

  # PATCH/PUT /settings/1
  def update
    authorize [current_user, 'Settings'], policy_class: ApplicationPolicy
    respond_to do |format|
      if current_user.update(setting_params)
        format.html { redirect_to root_url, notice: 'Settings were successfully updated.' }
      else
        format.html { render :index }
      end
    end
  end

  def setting_params
    params.require(:user).permit(user_settings_attributes: %i[id flag])
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include ApplicationHelper
  protect_from_forgery

  add_breadcrumb 'Home', :root_path
  rescue_from Pundit::NotAuthorizedError, with: :redirect_unauthorized

  def set_breadcrumb
    add_breadcrumb params[:controller].capitalize.to_s, send("#{params['controller']}_path")
    add_current_action_breadcrumb(params)
  end

  def add_current_action_breadcrumb(params)
    actions = %w[new edit]
    return unless actions.include?(params['action'])

    add_breadcrumb params[:action].capitalize.to_s,
                   send("#{params['action'] + '_' + params['controller'].singularize}_path")
  end

  def current_customer
    if params[:customer_id].present? && accessable?('Customers', 'is_readable')
      @customer = Customer.find(params[:customer_id])
    elsif cookies[:selected_customer].present? && accessable?('Customers', 'is_readable')
      @customer = Customer.find(cookies[:selected_customer].to_i)
    end
    @customer ||= current_user.customer
    @customer
  end

  def check_customer_authorication(user, record)
    redirect_unauthorized if user.customer != record.customer && !user.authorized_user?
  end

  private

  def redirect_unauthorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(root_path)
  end

  def combine_date_time(date, time)
    date.to_datetime + Time.parse(time).seconds_since_midnight.seconds
  end
end

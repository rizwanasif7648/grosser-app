# frozen_string_literal: true

class IncidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new index]
  before_action :sanitize_params, only: %i[create]

  # GET /incidents/new
  def new
    authorize [current_user, 'Create Incident'], policy_class: ApplicationPolicy
    @incident = Incident.new
    # @incident.product_incidents.build
  end

  # POST /incidents
  def create
    authorize [current_user, 'Create Incident'], policy_class: ApplicationPolicy
    @incident = Incident.new(incident_params)
    if @incident.valid? && @incident.save
      flash[:notice] = 'Incident was successfully created.'
    else
      flash[:alert] = @incident.errors.full_messages.to_sentence
    end
    redirect_to new_incident_url
  end

  # GET /incidents
  def index
    authorize [current_user, 'LogBook'], policy_class: ApplicationPolicy
    @customer = current_customer
    @incidents = @customer ? @customer.incidents.order(created_at: :desc) : []
    @incident_requests = @customer ? @customer.incident_requests.order(created_at: :desc) : []
  end

  def sanitize_params
    params[:incident][:date_time] = combine_date_time(params[:incident][:date_time],
                                                      params[:incident][:time])
    params[:incident][:created_by_id] = current_user.id
    params[:incident][:updated_by_id] = current_user.id
    unless params[:incident][:product_incidents_attributes].present?
      return flash[:alert] = 'Product must be selected'
    end

    params[:incident][:product_incidents_attributes].each do |_key, value|
      value.merge!(created_by_id: current_user.id, updated_by_id: current_user.id,
                   customer_id: params[:incident][:customer_id],
                   status: ProductIncident.statuses[:active])
    end
  end

  # Only allow a list of trusted parameters through.
  def incident_params
    params.require(:incident).permit(Incident::WHITELIST_ATTRIBUTES)
  end
end

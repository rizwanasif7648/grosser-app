# frozen_string_literal: true

module Api
  module V1
    class IncidentsController < ApiApplicationController
      before_action :authenticate_request
      before_action :sanitize_params, only: %i[create]

      api :GET, '/v1/incidents', 'Current User Incidents and Products List'
      error 401, 'If access_token is missing in headers.'
      description 'Current User Incidents and Products List'
      def index
        @incidents = @current_user.incidents.order(created_at: :desc)
        render 'index.json.jbuilder'
      end

      def_param_group :create_incident do
        param :customer_id, String, desc: 'customer id', required: true
        param :date_time, String, desc: 'created on Date Time', required: true
        param :product_incidents_attributes, Array, desc: 'Array of products', required: true do
          param :product_id, String, desc: 'Product id', required: true
          param :box_id, String, desc: 'Box id', required: true
          param :status, String, desc: 'Product status', required: true
          param :quantity, String, desc: 'Product quantity', required: true
        end
      end
      api :POST, '/v1/incidents', 'Create Incident'
      param_group :create_incident
      error 401, 'If access_token is missing in headers.'
      description 'Create Incident'
      def create
        @incident = Incident.new(incident_params)

        unless @incident.valid? && @incident.save!
          return render json: { message: @incident.errors.full_messages.to_sentence, status: 422 }
        end

        render json: { message: 'Incident has been successfully created', status: 200 }
      end

      private

      def sanitize_params
        params[:incident][:user_id] = @current_user.id
        params[:incident][:box_id] = params[:product_incidents_attributes][0][:box_id]
        params[:incident][:created_by_id] = @current_user.id
        params[:incident][:updated_by_id] = @current_user.id
        params[:incident][:product_incidents_attributes].each do |value|
          value.merge!(created_by_id: @current_user.id, updated_by_id: @current_user.id,
                       customer_id: params[:customer_id])
        end
      end

      def incident_params
        params.require(:incident).permit(Incident::WHITELIST_ATTRIBUTES)
      end
    end
  end
end

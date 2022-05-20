# frozen_string_literal: true

module Api
  module V1
    class IncidentRequestsController < ApiApplicationController
      include IncidentsConcerns
      before_action :sanitize_params, only: [:upload_incident_image]

      def_param_group :upload_incident_image do
        param :image, String, desc: 'Image', required: true
      end
      api :POST, '/v1/upload_incident_image', 'upload_incident_image'
      param_group :upload_incident_image
      error 400, 'If image string is not present.'
      description 'upload_incident_image'
      def upload_incident_image
        @incident = IncidentRequest.new(incident_params)
        save_image params
        if @incident.save
          render json: {
            message: 'Your incident has been successfully created.', status: 200
          }
        else
          render json: {
            message: 'Your incident has not been successfully created.', status: 422
          }
        end
      end

      def sanitize_params
        params[:incident_request][:user_id] = current_user.id
        params[:incident_request][:customer_id] = current_user.customer_id
        params[:incident_request][:created_by_id] = current_user.id
        params[:incident_request][:updated_by_id] = current_user.id
      end

      private

      def incident_params
        params.require(:incident_request).permit(:image, :user_id, :customer_id,
                                                 :created_by_id, :updated_by_id)
      end
    end
  end
end

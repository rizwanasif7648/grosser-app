# frozen_string_literal: true

module Api
  module V1
    class SupportsController < ApiApplicationController
      include SupportsConcerns
      before_action :sanitize_params, only: [:support]

      def_param_group :support do
        param :title, String, desc: 'Title', required: true
        param :body_message, String, desc: 'Message', required: true
      end
      api :POST, '/v1/support', 'Support'
      param_group :support
      description 'Support'
      def support
        support_message params
      end
    end
  end
end

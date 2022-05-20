# frozen_string_literal: true

module Api
  module V1
    class BoxesController < ApiApplicationController
      api :GET, '/v1/boxes', 'Current User Boxes and Products List'
      error 401, 'If access_token is missing in headers.'
      description 'Current User Boxes and Products List'
      def index
        @boxes = @current_user.boxes
        render 'index.json.jbuilder'
      end
    end
  end
end

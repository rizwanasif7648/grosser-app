# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncidentsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/incidents/new').to route_to('incidents#new')
    end

    it 'routes to #create' do
      expect(post: '/incidents').to route_to('incidents#create')
    end
  end
end

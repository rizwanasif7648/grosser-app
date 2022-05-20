# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /states' do
    it 'returns http success' do
      get '/states'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /cities' do
    it 'returns http success' do
      get '/cities'
      expect(response).to have_http_status(:success)
    end
  end
end

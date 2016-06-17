require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /{errorcode}' do
    it 'should return a 404' do
      get '/404'
      expect(response).to have_http_status(404)
    end

    it 'should return a 422' do
      get '/422'
      expect(response).to have_http_status(422)
    end

    it 'should return a 500' do
      get '/500'
      expect(response).to have_http_status(500)
    end
  end
end

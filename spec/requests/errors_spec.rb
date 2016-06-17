require 'rails_helper'

RSpec.describe "Errors", type: :request do
  describe "GET /" do
    it "works! (now write some real specs)" do
      get '/404'
      expect(response).to have_http_status(404)
    end

    it "works! (now write some real specs)" do
      get '/422'
      expect(response).to have_http_status(422)
    end

    it "works! (now write some real specs)" do
      get '/500'
      expect(response).to have_http_status(500)
    end
  end
end

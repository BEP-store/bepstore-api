require "rails_helper"

RSpec.describe ErrorsController, type: :routing do
  describe "routing" do

   it "routes to #show" do
      expect(:get => "/404").to route_to("errors#show", :code => "404")
    end

    it "routes to #show" do
      expect(:get => "/422").to route_to("errors#show", :code => "422")
    end

    it "routes to #show" do
      expect(:get => "/500").to route_to("errors#show", :code => "500")
    end
  end
end

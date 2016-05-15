require 'rails_helper'

RSpec.describe ApiHelper, type: :helper do
  describe '#ApiHelper' do
    describe '#resource_name' do
      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/activities')
        expect(resource_name).to eq('activity')
      end
    end

    describe '#resource_class' do
      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/activities_controllers')
        stub_const('ActivitiesController', 5)
        expect(resource_class).to eq(5)
      end
    end
  end
end

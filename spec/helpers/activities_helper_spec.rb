require 'rails_helper'

RSpec.describe ActivitiesHelper, type: :helper do

  describe '#ActivitiesHelper' do

    describe '#engine?' do
      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return({:controller => "bepstore/activities"})
        expect(helper.engine?).to eq(false)
      end

      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return({:controller => "bepstore/goals"})
        expect(helper.engine?).to eq(true)
      end
    end

    describe '#root' do
      # let!(:activity.present) {true}

      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return({:controller => "bepstore/goals"})
        expect(helper.root).to eq("goals")
      end

      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return({:controller => "bepstore/activities"})
        expect(helper.root).to eq("activities")
      end
    end
  end
end

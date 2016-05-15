require 'rails_helper'

RSpec.describe ActivitiesHelper, type: :helper do
  describe '#ActivitiesHelper' do
    describe '#engine?' do
      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/activities')
        expect(helper.engine?).to eq(false)
      end

      it 'returns whether or not the activity is an engine' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/goals')
        expect(helper.engine?).to eq(true)
      end
    end

    describe '#root' do
      it 'returns singular activity name if it is an engine and an activity is present' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/goals')
        assign(:activity, true)
        expect(helper.root).to eq('goal')
      end

      it 'returns singular activity name if it is not an engine and an activity is present' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/activities')
        assign(:activity, true)
        expect(helper.root).to eq('activity')
      end

      it 'returns plural activity name if it is an engine and an activity is not present' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/goals')
        expect(helper.root).to eq('goals')
      end

      it 'returns plural activity name if it is not an engine and an activity is not present' do
        allow(controller).to receive(:params).and_return(controller: 'bepstore/activities')
        expect(helper.root).to eq('activities')
      end
    end
  end
end

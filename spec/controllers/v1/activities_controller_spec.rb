require 'rails_helper'

RSpec.describe V1::ActivitiesController, type: :controller do
  describe 'GET #index' do
    let(:action) do
      proc do
        get :index
      end
    end

    describe 'should return the activities' do
        before { action.call }

        it { expect(JSON.parse(response.body)['activities'][0]['id']).to eq(activity2.id.to_s) }
        it { expect(JSON.parse(response.body)['activities'][1]['id']).to eq(activity.id.to_s) }
      end
  end

  describe 'GET #find' do
    let(:action) do
      proc do
        get :find, ids: [activity.id, activity2.id]
      end
    end
  end

  describe 'GET #show' do
    let(:action) do
      proc do
        get :show, id: activity2.id
      end
    end
  end
end

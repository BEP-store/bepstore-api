require 'rails_helper'

RSpec.describe V1::ActivitiesController, type: :controller do
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:activity2) { FactoryGirl.create(:activity) }

  it_behaves_like 'ActivitiesController'

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

    describe 'when enrolled' do
        before { action.call }

        it { expect(JSON.parse(response.body)['activities'][0]['id']).to eq(activity.id.to_s) }
        it { expect(JSON.parse(response.body)['activities'][1]['id']).to eq(activity2.id.to_s) }
    end

    describe 'when not enrolled' do
      it { expect(response.body).to be_empty }
    end
  end

  describe 'GET #show' do
    let(:action) do
      proc do
        get :show, id: activity2.id
      end
    end

    describe 'when enrolled or owner' do
      describe 'should return the activity' do
        before { action.call }

        it { expect(JSON.parse(response.body)['activity']['id']).to eq(activity2.id.to_s) }
      end
    end
  end

  # describe 'POST #create' do
  #   let(:action) do
  #     proc do
  #       post :create, type => params
  #     end
  #   end

  #   describe 'when enrolled or owner' do

  #     describe 'should return the activity' do
  #       before { action.call }

  #       it { expect(JSON.parse(response.body)['activity']['id']).to eq(activity2.id.to_s) }
  #     end
  #   end

  # end
  #

  # describe 'POST #create' do
  #   let(:action) do
  #     proc do
  #       post :create
  #     end
  #   end

  #   describe 'when enrolled or owner' do

  #     describe 'should return the activity' do
  #       before { action.call }

  #       it { expect(JSON.parse(response.body)['activity']['id']).to eq(activity2.id.to_s) }
  #     end
  #   end
  # end
end

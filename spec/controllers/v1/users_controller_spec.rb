require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  include_context 'authentication'

  let!(:user2) { FactoryGirl.create(:user) }

  describe 'GET #find' do
    let(:action) do
      proc do
        get :find, ids: [user.id, user2.id]
      end
    end

    it_behaves_like 'authenticated_action'

    describe 'should return the users' do
      before do
        action.call
      end

      it { expect(JSON.parse(response.body)['users'][0]['id']).to eq(user.id.to_s) }
      it { expect(JSON.parse(response.body)['users'][1]['id']).to eq(user2.id.to_s) }
    end
  end

  describe 'GET #show' do
    let(:action) do
      proc do
        get :show, id: user.id
      end
    end

    it_behaves_like 'authenticated_action'

    describe 'should return the user' do
      before { action.call }

      it { expect(JSON.parse(response.body)['user']['id']).to eq(user.id.to_s) }
    end
  end

  describe 'GET #current' do
    let(:action) do
      proc do
        get :current
      end
    end

    it_behaves_like 'authenticated_action'

    describe 'should return the current user' do
      before { action.call }

      it { expect(JSON.parse(response.body)['user']['id']).to eq(user.id.to_s) }
    end
  end

  describe 'POST #create' do
    let(:action) do
      proc do
        post :create, user: { name: 'User 1' }
      end
    end

    describe 'should return the current user' do
      before do
        request.env.delete 'HTTP_AUTHORIZATION'
        action.call
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(JSON.parse(response.body)['user']['name']).to eq('User 1') }
    end

    describe 'should fail on model validation error' do
      let(:failed_action) do
        request.env.delete 'HTTP_AUTHORIZATION'
        proc do
          post :create, user: { name: '' }
        end
      end

      before { failed_action.call }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(JSON.parse(response.body)['errors']['name']).to include("can't be blank") }
    end
  end

  describe 'PUT #update' do
    describe 'with the current user' do
      let(:action) do
        proc do
          put :update, id: user.id, user: { name: 'User 2' }
        end
      end

      it_behaves_like 'authenticated_action'

      describe 'should return the current user' do
        before { action.call }

        it { expect(JSON.parse(response.body)['user']['name']).to eq('User 2') }
      end

      describe 'should fail on model validation error' do
        before do
          allow_any_instance_of(User).to receive(:update!).and_raise(
            Mongoid::Errors::Validations, User.new.tap do |user|
              user.errors.add(:base, 'failed to update')
            end
          )
          action.call
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(JSON.parse(response.body)['errors']['base']).to include('failed to update') }
      end
    end

    describe 'with a different user' do
      let(:action) do
        proc do
          put :update, id: user2.id, user: { name: 'User 2' }
        end
      end

      it_behaves_like 'forbidden_action'
    end
  end
end

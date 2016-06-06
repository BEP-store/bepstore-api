shared_examples_for 'ActivitiesController' do
  include_context 'authentication'

  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:activity2) { FactoryGirl.create(:activity) }

  describe 'GET #index' do
    let(:action) do
      proc do
        get :index
      end
    end
  end

  describe 'GET #find' do
    let(:action) do
      proc do
        get :find,  params: { ids: [activity.id, activity2.id] }
      end
    end
  end

  describe 'GET #show' do
    let(:action) do
      proc do
        get :show,  params: { id: activity2.id }
      end
    end
  end

  describe 'POST #create' do
    let(:action) do
      proc do
        post :create,  params: { type => params }
      end
    end
  end

  describe 'PUT #update' do
      let(:action) do
        proc do
          put :update,  params: { id: activity.id, type => params }
        end
      end
  end

  describe 'DELETE #destroy' do
      let(:action) do
        proc do
          delete :destroy,  params: { id: activity.id }
        end
      end
  end
end

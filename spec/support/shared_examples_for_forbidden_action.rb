shared_examples_for 'forbidden_action' do
  describe 'without a an access_token' do
    before do
      request.headers['AUTHORIZATION'] = nil
      action.call
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  describe 'with an access_token' do
    before do
      request.headers['AUTHORIZATION'] = "Bearer #{user_access_token}"
      action.call
    end

    it { expect(response).to have_http_status(:forbidden) }
  end
end

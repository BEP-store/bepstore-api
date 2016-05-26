shared_examples_for 'authenticated_action' do
  describe 'without an access_token' do
    before do
      request.headers['AUTHORIZATION'] = nil
      action.call
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  describe 'with an expired access_token' do
    before do
      request.headers['AUTHORIZATION'] = "Bearer #{expired_access_token}"
      action.call
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  describe 'with an invalid access_token' do
    before do
      request.headers['AUTHORIZATION'] = "Bearer #{invalid_access_token}"
      action.call
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  describe 'with an access_token in header' do
    before do
      request.headers['AUTHORIZATION'] = "Bearer #{user_access_token}"
      action.call
    end

    it { expect(response).to have_http_status(:success) }
  end
end

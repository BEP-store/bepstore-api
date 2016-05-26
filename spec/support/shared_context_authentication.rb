shared_context 'authentication' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, admin: true) }

  let!(:fake_access_token) do
    JWT.encode(
      {
        sub: user.account_id,
        exp: 3.days.from_now.to_i,
        iss: 'FeedbackFruits Accounts'
      },
      'fakeSecret',
      'HS256'
    )
  end
  let!(:expired_access_token) do
    JWT.encode(
      {
        sub: user.account_id,
        exp: 3.days.ago.to_i,
        iss: 'FeedbackFruits Accounts'

      },
      Rails.application.config_for(:app)[:accounts_jwt_secret],
      'HS256'
    )
  end
  let!(:invalid_access_token) do
    JWT.encode(
      {
        sub: user.account_id,
        exp: 3.days.from_now.to_i,
        iss: 'Not FeedbackFruits Accounts'

      },
      Rails.application.config_for(:app)[:accounts_jwt_secret],
      'HS256'
    )
  end
  let!(:user_access_token) do
    JWT.encode(
      {
        sub: user.account_id,
        exp: 3.days.from_now.to_i,
        iss: 'FeedbackFruits Accounts'

      },
      Rails.application.config_for(:app)[:accounts_jwt_secret],
      'HS256'
    )
  end
  let!(:admin_access_token) do
    JWT.encode(
      {
        sub: admin.account_id,
        exp: 3.days.from_now.to_i,
        iss: 'FeedbackFruits Accounts'
      },
      Rails.application.config_for(:app)[:accounts_jwt_secret],
      'HS256'
    )
  end

  before do
    request.headers['AUTHORIZATION'] = "Bearer #{user_access_token}"

    uri_template =
      Addressable::Template.new "#{Rails.application.config_for(:app)[:accounts_url]}/users/{account_id}"

    stub_request(:any, uri_template)
      .with(headers: { 'Accept' => 'application/json' })
      .to_return(status: 200, body: {
        id: user.account_id,
        name: user.name,
        admin: user.admin
      }.to_json)
  end
end

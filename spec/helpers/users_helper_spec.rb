require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#UsersHelper' do
    let!(:subject) { SecureRandom.uuid }
    let!(:expiry) { 3.days.from_now.to_i }
    let!(:issuer) { 'FeedbackFruits Accounts' }

    let!(:account) do
      {
        id: subject,
        admin: false,
        name: 'mockName',
        emails: []
      }
    end

    let!(:user_access_token) do
      JWT.encode(
        {
          sub: subject,
          exp: expiry,
          iss: issuer

        },
        Rails.application.config_for(:app)[:accounts_jwt_secret],
        'HS256'
      )
    end

    let!(:subject) { SecureRandom.uuid }
    let!(:expiry) { 3.days.from_now.to_i }
    let!(:issuer) { 'FeedbackFruits Accounts' }

    let!(:token) do
      JWT.encode(
        {
          sub: subject,
          exp: expiry,
          iss: issuer

        },
        Rails.application.config_for(:app)[:accounts_jwt_secret],
        'HS256'
      )
    end

    before do
      controller.request.headers['AUTHORIZATION'] = "Bearer #{user_access_token}"

      client_id = Rails.application.config_for(:app)[:accounts_client_id]
      client_secret = Rails.application.config_for(:app)[:accounts_client_secret]
      url = "#{Rails.application.config_for(:app)[:accounts_url]}/auth/token"

      stub_request(:post, url)
        .with(basic_auth: [client_id, client_secret])
        .to_return(status: 200, body: { access_token: token }.to_json, headers: {})

      uri_template =
        Addressable::Template.new "#{Rails.application.config_for(:app)[:accounts_url]}/users/{account_id}"
      stub_request(:any, uri_template)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(status: 200, body: account.to_json)
    end

    describe '#access_token' do
      it 'returns the access_token' do
        expect(helper.access_token).to eq(user_access_token)
      end
    end

    describe '#access_token_valid?' do
      it 'returns whether or not the access token is valid' do
        expect(helper.access_token_valid?).to eq(helper.valid_token?(user_access_token))
      end
    end

    describe '#account' do
      it 'returns the account' do
        expect(helper.account).to eq(account)
      end
    end

    describe '#current_user' do
      it 'returns the current user' do
        expect(helper.current_user.account_id).to eq(subject)
      end
    end

    describe '#signed_in?' do
      it 'returns whether or not there is a valid current user' do
        expect(helper.signed_in?).to eq(helper.access_token_valid? && helper.current_user.present?)
      end
    end

    describe '#current_user' do
      it 'returns nil' do
        expect(helper.signed_in_user).to eq(nil)
      end
    end
  end
end

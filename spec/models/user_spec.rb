require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:admin) }
  it { should respond_to(:bio) }

  it { should validate_presence_of(:name) }

  it { should be_valid }

  describe '#create_from_account!' do
    before do
      client_id = Rails.application.config_for(:app)[:accounts_client_id]
      client_secret = Rails.application.config_for(:app)[:accounts_client_secret]
      url = "#{Rails.application.config_for(:app)[:accounts_url]}/auth/token"

      stub_request(:post, url)
        .with(basic_auth: [client_id, client_secret])
        .to_return(status: 200, body: { access_token: 'mockAccessToken' }.to_json, headers: {})

      stub_request(:post, "#{Rails.application.config_for(:app)[:accounts_url]}/users")
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: {
          id: 'mockId',
          admin: false,
          name: 'mockName',
          emails: []
        }.to_json, headers: {})
    end

    let(:account) { FactoryGirl.create(:account) }

    subject { described_class.create_from_account!(account.attributes.symbolize_keys) }

    describe 'should copy the account attributes' do
      it { expect(subject.account_id).to be(account.id) }
      it { expect(subject.name).to be(account.name) }
      it { expect(subject.admin).to be(account.admin) }
    end
  end
end

require 'rails_helper'

sub = SecureRandom.uuid
exp = 3.days.from_now.to_i
iss = 'FeedbackFruits Accounts'
secret = Rails.application.config_for(:app)[:accounts_jwt_secret]
token = JWT.encode({ sub: sub, exp: exp, iss: iss }, secret, 'HS256')

RSpec.describe Account, type: :model do
  before do
    described_class.remove_instance_variable :@access_token

    stub_request(:post, "#{Rails.application.config_for(:app)[:accounts_url]}/auth/token")
      .to_return(status: 200, body: { access_token: token }.to_json, headers: {})

    stub_request(:post, "#{Rails.application.config_for(:app)[:accounts_url]}/password_reset")
      .to_return(status: 200, body: '', headers: {})
  end

  describe 'access_token' do
    subject { described_class.access_token }

    describe 'should return the requested token' do
      it { expect(subject).to eq(token) }
    end
  end

  describe 'headers' do
    subject { described_class.headers }

    it { expect(subject).to eq('Authorization' => "Bearer #{token}") }
  end

  describe '#reset_password!' do
    describe 'should reset the password' do
      let(:account_id) { 'mockAccountId' }
      let(:new_password) { 'mockPassword' }

      subject { described_class.reset_password!(account_id, new_password) }

      it { expect(subject).to be_nil }
    end
  end
end

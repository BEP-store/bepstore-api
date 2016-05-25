require 'rails_helper'

RSpec.describe JwtHelper, type: :helper do
  describe '#JwtHelper' do
    let!(:sub) { SecureRandom.uuid }
    let!(:exp) { 3.days.from_now.to_i }
    let!(:iss) { 'FeedbackFruits Accounts' }

    let!(:token) do
      JWT.encode(
        {
          sub: sub,
          exp: exp,
          iss: iss

        },
        Rails.application.config_for(:app)[:accounts_jwt_secret],
        'HS256'
      )
    end

    describe '#payload' do
      it 'returns the decoded payload' do
        expect(helper.payload(token)).to eq(sub: sub, exp: exp, iss: iss)
      end
    end

    describe '#issuer' do
      it 'returns the decoded issuer' do
        expect(helper.issuer(token)).to eq(iss)
      end
    end

    describe '#subject' do
      it 'returns the decoded payload' do
        expect(helper.subject(token)).to eq(sub)
      end
    end

    describe '#expiry' do
      it 'returns the decoded expiry' do
        expect(helper.expiry(token)).to eq(Time.at(exp).utc.to_datetime)
      end
    end

    describe '#valid_token?' do
      it 'returns whether or not the access token is valid' do
        expect(helper.valid_token?(token)).to eq(helper.payload(token).present? && helper.expiry(token).future? && helper.issuer(token).eql?('FeedbackFruits Accounts'))
      end
    end
  end
end

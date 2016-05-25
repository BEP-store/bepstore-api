module JwtHelper
  def payload(token)
    JWT.decode(token, Rails.application.config_for(:app)[:accounts_jwt_secret], true, algorithm: 'HS256').first.symbolize_keys if token.present?
  end

  def issuer(token)
    return if payload(token).nil?
    payload(token)[:iss]
  end

  def subject(token)
    return if payload(token).nil?
    payload(token)[:sub]
  end

  def expiry(token)
    return if payload(token).nil?
    Time.at(payload(token)[:exp]).utc.to_datetime
  end

  def valid_token?(token)
    return false if payload(token).nil?
    payload(token).present? && expiry(token).future? && issuer(token).eql?('FeedbackFruits Accounts')
  end
end

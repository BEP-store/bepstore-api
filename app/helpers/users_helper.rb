module UsersHelper
  include JwtHelper

  def current_user
    return unless access_token_valid?
    return @current_user if @current_user.present? && @current_user.account_id.eql?(account_id)

    user = User.find_by(account_id: account_id)
    user = User.create_from_account!(account) if user.nil?

    @current_user = user
  end

  def signed_in?
    # access_token_valid? &&
    current_user.present?
  end

  def signed_in_user
    head(:unauthorized) unless signed_in?
  end

  def access_token
    if request.headers['AUTHORIZATION'].present?
      token_type, token = request.headers['AUTHORIZATION'].split
      @access_token ||= token if token_type == 'Bearer'
    elsif request.params['access_token'].present?
      @access_token ||= request.params['access_token']
    end
  end

  def access_token_valid?
    @access_token_valid ||= valid_token?(access_token)
  rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::InvalidIssuerError, JWT::VerificationError
    head(:unauthorized)
    return false
  end

  def account_id
    @account_id ||= subject(access_token)
  end

  def account
    return @account if @account.present?
    @account = Account.get(account_id).symbolize_keys
  end
end

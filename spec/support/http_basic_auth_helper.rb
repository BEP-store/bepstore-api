module HttpBasicAuthHelper
  def http_basic_auth_login(email, password)
    request.env['AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end

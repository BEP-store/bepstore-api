class Account < ActiveResource::Base
  include ActiveModel::SerializerSupport
  extend JwtHelper

  self.site = Rails.application.config_for(:app)[:accounts_url]
  self.element_name = 'user'
  self.include_format_in_path = false
  self.prefix = '/'

  schema do
    attribute 'id', :string
    attribute 'name', :string
    attribute 'admin', :boolean
  end

  def self.access_token
    return @access_token if valid_token?(@access_token)
    client_id = Rails.application.config_for(:app)[:accounts_client_id]
    client_secret = Rails.application.config_for(:app)[:accounts_client_secret]

    @access_token = JSON.parse(HTTParty.post(
      "#{site}/auth/token",
      headers: {
        'Authorization' => "Basic #{Base64.encode64("#{client_id}:#{client_secret}")}"
      },
      body: {
        grant_type: 'client_credentials',
        client_id: client_id,
        client_secret: client_secret
      }).body)['access_token']
  end

  class << self
    attr_writer :access_token
  end

  def self.headers
    { 'Authorization' => "Bearer #{access_token}" }
  end

  def self.reset_password!(account_id, new_password)
    HTTParty.post(
      "#{site}/password_reset",
      headers: headers,
      body: {
        id: account_id,
        password: new_password
      })
  end
end

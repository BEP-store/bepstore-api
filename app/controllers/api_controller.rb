class ApiController < ApplicationController
  include Pundit
  include ApiHelper
  include UsersHelper

  before_action :signed_in_user
  after_action :verify_policy_scoped, except: :create
  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :rescue_from_not_authorized
  rescue_from Pundit::NotDefinedError, with: :rescue_from_not_defined
  rescue_from Mongoid::Errors::Validations, with: :rescue_from_validation_error

  private

  def rescue_from_not_authorized(exception)
    render json: { errors: [exception.message] }, status: :forbidden
    false
  end

  def rescue_from_not_defined(exception)
    render json: { errors: [exception.message] }, status: 501
    false
  end

  def rescue_from_validation_error(exception)
    render json: exception.document, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    false
  end
end

class ApiController < ApplicationController
  include Pundit
  include ApiHelper
  include UsersHelper

  before_action :signed_in_user
  after_action :verify_policy_scoped, except: :create
  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :rescue_from_not_authorized
  rescue_from Mongoid::Errors::Validations, with: :rescue_from_validation_error

  private

  def rescue_from_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:warning] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
  end

  def rescue_from_validation_error(exception)
    render json: { errors: exception.document.errors }, status: :unprocessable_entity
    false
  end
end

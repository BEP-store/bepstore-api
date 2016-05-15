class ApiController < ApplicationController
  include ApiHelper

  rescue_from Mongoid::Errors::Validations, with: :rescue_from_validation_error

  private

  def rescue_from_validation_error(exception)
    render json: { errors: exception.document.errors }, status: :unprocessable_entity
    false
  end
end

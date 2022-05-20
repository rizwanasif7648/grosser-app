# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::DecodeError, with: :four_zero_one

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(exception)
    puts 'four_twenty_two'
    render json: { message: exception.message }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 401 - Unauthorized
  def four_ninety_eight(exception)
    puts 'four_ninety_eight'
    render json: { message: exception.message }, status: :invalid_token
  end

  # JSON response with message; Status code 401 - Unauthorized
  def four_zero_one(exception)
    puts 'four_zero_one'
    render json: { message: exception.message }, status: :invalid_token
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(exception)
    puts 'unauthorized_request'
    render json: { message: exception.message }, status: :unauthorized
  end
end

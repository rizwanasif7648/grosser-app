# frozen_string_literal: true

module SupportsConcerns
  extend ActiveSupport::Concern

  def support_message(_params)
    @support = Support.new(support_params)
    if @support.save
      UserMailer.support(@support, current_user).deliver_later
      render json: {
        message: 'Your message has been successfully sent to 3W-health admin', status: 200
      }
    else
      render json: {
        message: 'Your message has not been successfully sent to 3W-health admin', status: 422
      }
    end
  end

  def sanitize_params
    params[:to] = ENV['SENDER_EMAIL']
    params[:from] = current_user.email
  end

  private

  def support_params
    params.permit(:title, :body_message, :to, :from)
  end
end

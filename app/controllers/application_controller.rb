# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class NotAuthorized < StandardError; end

  rescue_from NotAuthorized, with: :not_authorized

  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  private

  def authenticate_user!
    raise NotAuthorized unless current_user
  end

  def not_authorized
    redirect_to root_path, flash: { danger: 'Please sign in' }
  end
end

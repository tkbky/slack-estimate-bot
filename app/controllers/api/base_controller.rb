# frozen_string_literal: true
class NotAuthorized < StandardError; end

class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :prepare_payload
  before_action :authorize!

  rescue_from NotAuthorized do
    render json: {}, status: :forbidden
  end

  private

  def authorize!
    raise NotAuthorized if @payload[:token] != ENV['SLACK_VERIFICATION_TOKEN']
  end

  def prepare_payload
    @payload = JSON.parse(params[:payload]).with_indifferent_access
  end
end

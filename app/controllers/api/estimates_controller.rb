# frozen_string_literal: true
require 'slack_bot_server/remote_control'

class Api::EstimatesController < Api::BaseController
  def create
    payload, attachment = Estimate::Disclose.new(@payload).call
    render json: { text: payload[:original_message][:text], replace_original: true, delete_original: false, response_type: :in_channel, attachments: [attachment] }, status: :ok
  end
end

# frozen_string_literal: true
class Api::EstimatesController < Api::BaseController
  include ActionView::Helpers::TextHelper

  def create
    attachment = @payload[:original_message][:attachments].first.dup
    point = @payload[:actions].first[:value]
    estimate = Estimate.find(@payload[:callback_id])
    estimate.update!(point: point, status: 'completed')
    attachment[:text] = "You gave an estimation of #{pluralize(point, 'point')}. Thank you for your time."
    attachment[:actions].clear
    render json: { text: @payload[:original_message][:text], replace_original: true, delete_original: false, response_type: :in_channel, attachments: [attachment] }, status: :ok
  end
end

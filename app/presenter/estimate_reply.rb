# frozen_string_literal: true
class EstimateReply
  include ActionView::Helpers::TextHelper

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def to_h
    { text: text, replace_original: true, delete_original: false, response_type: :in_channel, attachments: [attachment] }
  end

  private

  def text
    payload[:original_message][:text]
  end

  def point
    payload[:actions].first[:value]
  end

  def attachment
    payload[:original_message][:attachments].first.merge(text: "You gave an estimation of *#{pluralize(point, 'point')}*. Thank you for your time.", mrkdwn_in: ['text'], actions: [])
  end
end

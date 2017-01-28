# frozen_string_literal: true
class Estimate::Disclose
  include ActionView::Helpers::TextHelper

  attr_reader :payload, :team, :estimate, :story

  def initialize(payload)
    @payload = payload
    @team = Team.find_by!(slack_id: payload[:team][:id])
    @estimate = Estimate.find(payload[:callback_id])
    @story = estimate.story
  end

  def call
    @estimate.update!(point: point, status: 'completed')
    Estimate::Summarize.new(team, story).call unless story.estimates.any?(&:pending?)
    [payload, attachment]
  end

  private

  def point
    payload[:actions].first[:value]
  end

  def attachment
    payload[:original_message][:attachments].first.merge(text: "You gave an estimation of *#{pluralize(point, 'point')}*. Thank you for your time.", mrkdwn_in: ['text'], actions: [])
  end
end

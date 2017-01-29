# frozen_string_literal: true
require 'slack_bot_server/remote_control'

class Api::EstimatesController < Api::BaseController
  before_action :prepare_team

  def create
    @estimate = Estimate.find(@payload[:callback_id])
    reply = ReplyEstimate.new(@payload, @estimate).call!
    SlackRemote.new(@team.bot_access_token).say(channel: "##{@team.incoming_webhook_channel}", text: EstimateSummary.new(@estimate.story).to_s) unless @estimate.story.estimates.any?(&:pending?)
    render json: reply.to_h, status: :ok
  end

  private

  def prepare_team
    @team = Team.find_by!(slack_id: @payload[:team][:id])
  end
end

# frozen_string_literal: true
class OauthsController < ApplicationController
  def show
    resp = SlackOauth.new(params[:code]).authenticate
    if resp.ok
      Team.create_with(
        name: resp.team_name,
        incoming_webhook_url: resp.incoming_webhook.url,
        incoming_webhook_channel: resp.incoming_webhook.channel,
        incoming_webhook_config_url: resp.incoming_webhook.configuration_url,
        bot_user_id: resp.bot.bot_user_id,
        bot_access_token: resp.bot.bot_access_token,
        access_token: resp.access_token,
        scope: resp.scope
      ).find_or_create_by(slack_id: resp.team_id)

      redirect_to root_path, flash: { success: 'OK' }
    else
      redirect_to root_path, flash: { alert: resp.error }
    end
  end
end

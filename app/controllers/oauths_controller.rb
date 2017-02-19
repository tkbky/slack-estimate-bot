# frozen_string_literal: true
class OauthsController < ApplicationController
  def show
    resp = SlackOauth.new(params[:code]).authenticate

    return redirect_to root_path, flash: { danger: resp.error } unless resp.ok

    if resp.user
      find_or_create_user(resp)
    else
      find_or_create_team(resp)
    end
  end

  private

  def find_or_create_user(resp)
    user = User.create_with(
      name: resp.user.name,
      email: resp.user.email,
      slack_id: resp.user.id
    ).find_or_initialize_by(email: resp.user.email, slack_id: resp.user.id)

    if user.save
      session[:user_id] = user.id
      redirect_to me_dashboard_path, flash: { success: 'Signed in successfully' }
    else
      redirect_to root_path, flash: { danger: user.errors.full_messages.to_sentence }
    end
  end

  def find_or_create_team(resp)
    team = Team.create_with(
      name: resp.team_name,
      incoming_webhook_url: resp.incoming_webhook.url,
      incoming_webhook_channel: resp.incoming_webhook.channel,
      incoming_webhook_config_url: resp.incoming_webhook.configuration_url,
      bot_user_id: resp.bot.bot_user_id,
      bot_access_token: resp.bot.bot_access_token,
      access_token: resp.access_token,
      scope: resp.scope
    ).find_or_initialize_by(slack_id: resp.team_id)

    if team.save
      redirect_to me_dashboard_path, flash: { success: 'Bot has been added to your team successfully' }
    else
      redirect_to root_path, flash: { danger: team.errors.full_messages.to_sentence }
    end
  end
end

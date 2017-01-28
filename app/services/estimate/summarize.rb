# frozen_string_literal: true
class Estimate::Summarize
  attr_reader :team, :story, :remote

  def initialize(team, story)
    @team = team
    @story = story
    @remote = SlackBotServer::RemoteControl.new(queue: SlackBotServer::RedisQueue.new)
  end

  def call
    remote.add_bot(team.bot_access_token)
    remote.say(team.bot_access_token, channel: "##{team.incoming_webhook_channel}", text: summary, mrkdwn: true)
  end

  private

  def estimator_mentions
    story.estimates.map { |e| "<@#{e.user_slack_id}>" }
  end

  def estimations
    story.estimates
         .group_by(&:point)
         .map { |pt, es| "`#{pt}` - #{es.map { |e| "<@#{e.user_slack_id}>" }.join(', ')}" }
  end

  def summary
    <<-EOT
Good job team! #{estimator_mentions.join(' ')} :tada: :tada:
Here is the estimations for *\"#{story.title}\"*,
#{estimations.join("\n")}
EOT
  end
end

# frozen_string_literal: true
require 'slack_bot_server/remote_control'

class SlackRemote
  attr_reader :token, :remote

  def initialize(token)
    @token = token
    @remote = SlackBotServer::RemoteControl.new(queue: SlackBotServer::RedisQueue.new)
  end

  def say(channel:, text:)
    remote.add_bot(token)
    remote.say(token, channel: channel, text: text, mrkdwn: true)
  end
end

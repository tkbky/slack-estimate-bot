# frozen_string_literal: true
class SlackOauth
  attr_reader :code, :client

  def initialize(code)
    @code = code
    @client = Slack::Web::Client.new
  end

  def authenticate
    client.oauth_access(client_id: ENV['SLACK_CLIENT_ID'], client_secret: ENV['SLACK_CLIENT_SECRET'], code: code)
  end
end

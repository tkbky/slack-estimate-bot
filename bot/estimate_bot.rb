# frozen_string_literal: true
require 'slack_bot_server/bot'

class EstimateBot < SlackBotServer::Bot
  username 'Eva'

  def initialize(token:, team:)
    @team = team
    super(token: token)
  end

  icon_url ENV['BOT_ICON_URL']

  on_mention do |data|
    if data['message'] =~ /\Aestimate\s+\X(.*)\X\s+(.*)/
      # FIXME: find_or_create_by!, then make `title` unique per team && per project?
      story = @team.stories.create!(title: Regexp.last_match(1))
      estimators = Regexp.last_match(2).split(/\s+|,/)
      estimators.each do |estimator|
        estimator_id = estimator[2..-2]
        estimate = story.estimates.create!(user_slack_id: estimator_id)
        attachments = [
          {
            "text": 'Choose one of the following estimation points',
            "fallback": 'You are unable to estimate',
            "callback_id": estimate.id, # FIXME: use UUID
            "color": '#3AA3E3',
            "attachment_type": 'default',
            "actions": [
              {
                "name": 'one',
                "text": '1',
                "type": 'button',
                "value": '1'
              },
              {
                "name": 'two',
                "text": '2',
                "type": 'button',
                "value": '2'
              },
              {
                "name": 'three',
                "text": '3',
                "type": 'button',
                "value": '3'
              },
              {
                "name": 'five',
                "text": '5',
                "type": 'button',
                "value": '5'
              },
              {
                "name": 'eight',
                "text": '8',
                "type": 'button',
                "value": '8'
              }
            ]
          }
        ]

        say_to estimator_id, text: "What is your estimation for *\"#{story.title}\"*", attachments: attachments, mrkdwn: true
      end
    else
      reply text: "Sorry, I don't understand this command! \"#{data['message']}\""
    end
  end
end

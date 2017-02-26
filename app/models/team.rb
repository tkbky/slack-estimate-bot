# frozen_string_literal: true
class Team < ActiveRecord::Base
  has_many :stories, inverse_of: :team
  has_many :team_memberships
  has_many :users, through: :team_memberships

  validates :slack_id, presence: true, uniqueness: { scope: :incoming_webhook_channel }
  validates :name, presence: true
  validates :incoming_webhook_url, presence: true
  validates :incoming_webhook_channel, presence: true
  validates :incoming_webhook_config_url, presence: true
  validates :access_token, presence: true
  validates :scope, presence: true
end

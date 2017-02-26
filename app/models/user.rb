# frozen_string_literal: true
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :slack_id, presence: true, uniqueness: { case_sensitive: false }

  has_many :team_memberships
  has_many :teams, through: :team_memberships
end

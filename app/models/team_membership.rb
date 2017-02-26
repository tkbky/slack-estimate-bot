# frozen_string_literal: true
class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :user, presence: true
  validates :team, presence: true
  validates :user_id, uniqueness: { scoped: :team_id }
end

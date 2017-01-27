# frozen_string_literal: true
class Estimate < ActiveRecord::Base
  STATUSES = %w(pending completed).freeze
  POINTS = [0, 1, 2, 3, 5, 8].freeze

  belongs_to :story, inverse_of: :estimates

  validates :story, presence: true
  validates :user_slack_id, presence: true, uniqueness: { scope: :story_id }
  validates :point, inclusion: { in: POINTS }, if: -> { point.present? }
  validates :status, presence: true, inclusion: { in: STATUSES }
end

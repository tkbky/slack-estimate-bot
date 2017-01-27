# frozen_string_literal: true
class Story < ActiveRecord::Base
  belongs_to :team, inverse_of: :stories
  has_many :estimates, inverse_of: :story, dependent: :destroy

  validates :title, presence: true
  validates :team, presence: true
end

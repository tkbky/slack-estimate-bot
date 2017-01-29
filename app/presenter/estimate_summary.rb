# frozen_string_literal: true
class EstimateSummary
  attr_reader :story

  def initialize(story)
    @story = story
  end

  def to_s
    <<-EOT
Good job team! #{estimator_mentions.join(' ')} :tada: :tada:
Here is the estimations for *\"#{story.title}\"*,
#{estimations.join("\n")}
EOT
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
end

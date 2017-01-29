# frozen_string_literal: true
class ReplyEstimate
  attr_reader :payload, :estimate

  def initialize(payload, estimate)
    @payload = payload
    @estimate = estimate
  end

  def call!
    @estimate.update!(point: point, status: 'completed')
    EstimateReply.new(payload)
  end

  private

  def point
    payload[:actions].first[:value]
  end
end

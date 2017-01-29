require 'rails_helper'

RSpec.describe EstimateReply, type: :presenter do

  subject { described_class.new(payload) }

  let(:payload) do
    {
      original_message: {
        text: text,
        attachments: [attachment]
      },
      actions: [
        {
          value: value
        }
      ]
    }
  end
  let(:expected_hash) do
    {
      text: text,
      replace_original: true,
      delete_original: false,
      response_type: :in_channel,
      attachments: [attachment]
    }
  end
  let(:value) { 8 }
  let(:text) { 'text' }
  let(:attachment) do
    {
      text: "You gave an estimation of *#{value} points*. Thank you for your time.",
      mrkdwn_in: ['text'],
      actions: []
    }
  end

  it { expect(subject.to_h).to eq(expected_hash) }

end

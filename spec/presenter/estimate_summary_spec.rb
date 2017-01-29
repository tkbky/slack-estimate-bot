require 'rails_helper'

RSpec.describe EstimateSummary, type: :presenter do

  subject { described_class.new(story) }

  let(:expected_to_s) do
<<-EOT
Good job team! <@#{estimate_1.user_slack_id}> <@#{estimate_2.user_slack_id}> :tada: :tada:
Here is the estimations for *\"#{story.title}\"*,
`#{point}` - <@#{estimate_1.user_slack_id}>, <@#{estimate_2.user_slack_id}>
EOT
  end

  let(:story) { create(:story) }
  let!(:estimate_1) { create(:estimate, story: story, point: point) }
  let!(:estimate_2) { create(:estimate, story: story, point: point) }
  let(:point) { 8 }

  it { expect(subject.to_s).to eq(expected_to_s) }

end

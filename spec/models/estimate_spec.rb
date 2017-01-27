require 'rails_helper'

RSpec.describe Estimate, type: :model do

  it { is_expected.to belong_to(:story).inverse_of(:estimates) }

  context 'without point' do

    subject { build(:estimate) }

    it { is_expected.to validate_presence_of(:story) }
    it { is_expected.to validate_presence_of(:user_slack_id) }
    it { is_expected.to validate_uniqueness_of(:user_slack_id).scoped_to(:story_id) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(Estimate::STATUSES) }

  end

  context 'with point' do

    subject { build(:estimate, :with_point) }

    it { is_expected.to validate_inclusion_of(:point).in_array(Estimate::POINTS) }

  end

end

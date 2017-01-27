require 'rails_helper'

RSpec.describe Team, type: :model do

  subject { build(:team) }

  it { is_expected.to validate_presence_of(:slack_id) }
  it { is_expected.to validate_uniqueness_of(:slack_id).scoped_to(:incoming_webhook_channel) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:incoming_webhook_url) }
  it { is_expected.to validate_presence_of(:incoming_webhook_channel) }
  it { is_expected.to validate_presence_of(:incoming_webhook_config_url) }
  it { is_expected.to validate_presence_of(:access_token) }
  it { is_expected.to validate_presence_of(:scope) }

end

require 'rails_helper'

RSpec.describe User, type: :model do

  subject { build(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:slack_id) }
  it { is_expected.to validate_uniqueness_of(:slack_id).case_insensitive }

end

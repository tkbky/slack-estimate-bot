require 'rails_helper'

RSpec.describe Story, type: :model do

  it { is_expected.to belong_to(:team).inverse_of(:stories) }
  it { is_expected.to have_many(:estimates).inverse_of(:story).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:team) }

end

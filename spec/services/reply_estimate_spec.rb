require 'rails_helper'

RSpec.describe ReplyEstimate, type: :service do

  subject { described_class.new(payload, estimate) }

  let(:payload) do
    {
      actions: [
        {
          value: value
        }
      ]
    }
  end
  let(:estimate) { create(:estimate) }

  describe '#call' do

    context 'with valid payload' do

      let(:value) { 3 }

      it { expect { subject.call! } .to change { estimate.reload.point }.to(value) }
      it { expect { subject.call! } .to change { estimate.reload.status}.to("completed") }
      it { expect(subject.call!).to be_a(EstimateReply) }

    end

    context 'with invalid payload' do

      let(:value) { 4 }

      it { expect { subject.call! }.to raise_error(ActiveRecord::RecordInvalid) }

    end

  end

end

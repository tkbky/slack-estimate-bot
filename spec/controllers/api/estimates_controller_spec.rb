require 'rails_helper'

RSpec.describe Api::EstimatesController, type: :controller do

  context 'with invalid token' do

    let(:payload) do
      {
        token: 'foo'
      }.to_json
    end

    it 'responds with 403' do
      ClimateControl.modify(SLACK_VERIFICATION_TOKEN: 'bar') do
        expect(post(:create, payload: payload)).to have_http_status(:forbidden)
      end
    end

  end

  describe 'POST #create' do

    let(:payload) do
      {
        actions: [
          {
            value: expected_point
          }
        ],
        token: token,
        callback_id: estimate.id,
        original_message: {
          text: expected_message_text,
          attachments: attachments
        }
      }.to_json
    end
    let(:attachments) do
      [
        {
          text: 'some attachments 1 texts',
          actions: [
            {
              name: 'action 1',
              value: 1,
            }
          ]
        }
      ]
    end

    let(:estimate) { create(:estimate) }
    let(:token) { 'token' }
    let(:expected_point) { 1 }
    let(:expected_status) { 'completed' }
    let(:expected_message_text) { "some texts" }
    let(:expected_json) { JSON.parse(response.body).with_indifferent_access }

    before do
      ClimateControl.modify(SLACK_VERIFICATION_TOKEN: token) do
        post :create, payload: payload
      end
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(estimate.reload.point).to eq(expected_point) }
    it { expect(estimate.reload.status).to eq(expected_status) }
    it { expect(expected_json).to include(:text, :replace_original, :delete_original, :response_type, :attachments) }
    it { expect(expected_json[:text]).to eq(expected_message_text) }
    it { expect(expected_json[:replace_original]).to be true }
    it { expect(expected_json[:delete_original]).to be false }
    it { expect(expected_json[:response_type]).to eq('in_channel') }
    it { expect(expected_json[:attachments].first[:text]).to eq("You gave an estimation of #{expected_point} point. Thank you for your time.") }
    it { expect(expected_json[:attachments].first[:actions]).to be_empty }

  end

end

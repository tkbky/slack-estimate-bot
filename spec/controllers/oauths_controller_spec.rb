require 'rails_helper'

RSpec.describe OauthsController, type: :controller do

  describe 'GET #show' do

    let(:slack_oauth) { instance_double(SlackOauth) }
    let(:resp) { double('resp') }
    let(:incoming_webhook) { double('incoming_webhook') }
    let(:bot) { double('bot') }

    before do
      allow(SlackOauth).to receive(:new).with(code) { slack_oauth }
      allow(slack_oauth).to receive(:authenticate) { resp }
      allow(resp).to receive(:ok) { ok }
      allow(resp).to receive(:team_name) { 'team_name' }
      allow(resp).to receive(:team_id) { 'team_id' }
      allow(resp).to receive(:access_token) { 'access_token' }
      allow(resp).to receive(:scope) { 'scope' }
      allow(resp).to receive(:incoming_webhook) { incoming_webhook }
      allow(resp).to receive(:bot) { bot }
      allow(incoming_webhook).to receive(:url) { 'url' }
      allow(incoming_webhook).to receive(:channel) { 'channel' }
      allow(incoming_webhook).to receive(:configuration_url) { 'configuration_url' }
      allow(bot).to receive(:bot_user_id) { 'bot_user_id' }
      allow(bot).to receive(:bot_access_token) { 'bot_access_token' }
    end

    let(:code) { 'code' }

    context 'when success' do

      let(:ok) { true }

      before { get :show, code: code }

      it { expect(response).to redirect_to(root_path) }
      it { expect(controller).to set_flash[:success] }

    end

    context 'when success & team already exist' do

      let(:ok) { true }

      before do
        create(:team, slack_id: 'team_id')
        get :show, code: code
      end

      it { expect(response).to redirect_to(root_path) }
      it { expect(controller).to set_flash[:success] }

    end

    context 'when fail' do

      let(:ok) { false }

      before do
        allow(resp).to receive(:error) { 'error' }
        get :show, code: code
      end

      it { expect(response).to redirect_to(root_path) }
      it { expect(controller).to set_flash[:alert] }

    end

  end

end

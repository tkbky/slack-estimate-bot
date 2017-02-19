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

    context 'when add to slack' do

      before do
        allow(resp).to receive(:user) { nil }
      end

      context 'when success' do

        let(:ok) { true }

        before { get :show, code: code }

        it { expect(response).to redirect_to(me_dashboard_path) }
        it { expect(controller).to set_flash[:success] }

      end

      context 'when success but create team fail' do

        let(:ok) { true }

        before do
          allow(resp).to receive(:team_name) { '' }
        end

        before { get :show, code: code }

        it { expect(response).to redirect_to(root_path) }
        it { expect(controller).to set_flash[:danger] }

      end

      context 'when success & team already exist' do

        let(:ok) { true }

        before do
          create(:team, slack_id: 'team_id')
          get :show, code: code
        end

        it { expect(response).to redirect_to(me_dashboard_path) }
        it { expect(controller).to set_flash[:success] }

      end

      context 'when fail' do

        let(:ok) { false }

        before do
          allow(resp).to receive(:error) { 'error' }
          get :show, code: code
        end

        it { expect(response).to redirect_to(root_path) }
        it { expect(controller).to set_flash[:danger] }

      end

    end

    context 'when sign in with slack' do

      let(:user) { double('user') }

      before do
        allow(resp).to receive(:user) { user }
        allow(user).to receive(:name) { 'name' }
        allow(user).to receive(:email) { 'email' }
        allow(user).to receive(:id) { 'id' }
      end

      context 'when success' do

        let(:ok) { true }

        before { get :show, code: code }

        it { expect(response).to redirect_to(me_dashboard_path) }
        it { expect(controller).to set_flash[:success] }

      end

      context 'when success but create user fail' do

        let(:ok) { true }

        before do
          allow(user).to receive(:name) { '' }
        end

        before { get :show, code: code }

        it { expect(response).to redirect_to(root_path) }
        it { expect(controller).to set_flash[:danger] }

      end

      context 'when success & user already exist' do

        let(:ok) { true }

        before do
          create(:team, slack_id: 'team_id')
          get :show, code: code
        end

        it { expect(response).to redirect_to(me_dashboard_path) }
        it { expect(controller).to set_flash[:success] }

      end

      context 'when fail' do

        let(:ok) { false }

        before do
          allow(resp).to receive(:error) { 'error' }
          get :show, code: code
        end

        it { expect(response).to redirect_to(root_path) }
        it { expect(controller).to set_flash[:danger] }

      end

    end

  end

end

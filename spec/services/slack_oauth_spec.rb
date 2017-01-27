require 'rails_helper'

RSpec.describe SlackOauth, type: :service do

  subject { described_class.new(code) }

  describe '#authenticate' do

    let(:slack_web_client) { instance_double(Slack::Web::Client) }
    let(:client_id) { 'client_id' }
    let(:client_secret) { 'client_secret' }
    let(:code) { 'code' }

    it 'requests for oauth access' do
      ClimateControl.modify(SLACK_CLIENT_ID: client_id, SLACK_CLIENT_SECRET: client_secret) do
        expect(Slack::Web::Client).to receive(:new) { slack_web_client }
        expect(slack_web_client).to receive(:oauth_access).with(client_id: client_id, client_secret: client_secret, code: code)
        subject.authenticate
      end
    end

  end

end

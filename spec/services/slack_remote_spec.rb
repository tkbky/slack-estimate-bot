require 'rails_helper'

RSpec.describe SlackRemote, type: :service do
  subject { described_class.new(token) }
  let(:token) { 'token' }

  describe '.initialize' do
    it 'initializes a slack remote control' do
      expect(SlackBotServer::RemoteControl).to receive(:new).with(hash_including(:queue))
      subject
    end
  end

  describe '#say' do
    let(:remote) { instance_double(SlackBotServer::RemoteControl) }
    let(:channel) { '#channel' }
    let(:text) { 'text' }

    before do
      allow(SlackBotServer::RemoteControl).to receive(:new) { remote }
    end

    it 'adds bot to the remote & says something' do
      expect(remote).to receive(:add_bot).with(token)
      expect(remote).to receive(:say).with(token, channel: channel, text: text, mrkdwn: true)
      subject.say(channel: channel, text: text)
    end
  end
end

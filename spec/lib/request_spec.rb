require 'spec_helper'

describe PushBot::Request do
  describe '#request' do
    describe 'POST' do
      let(:id) { 42 }
      let(:secret) { 'super_secret_key' }
      let(:type) { :all }
      let(:options) { { msg:'foo', platform: '0' } }
      let(:url) { "https://api.pushbots.com/push/#{type}" }
      let(:headers) {
        {
          'X-PushBots-AppID' => id,
          'X-PushBots-Secret' => secret,
          'Content-Type' => 'application/json'
        }
      }

      before do
        PushBot.configure do |config|
          config.id = id
          config.secret = secret
        end
      end


      it 'RestClient::Request should receive #new' do
        expect(RestClient).to receive(:post).with(url, JSON.dump(options), headers)
        described_class.new(:push).post(type, options)
      end
    end
  end #request
end

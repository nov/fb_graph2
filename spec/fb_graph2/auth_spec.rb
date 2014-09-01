require 'spec_helper'

describe FbGraph2::Auth do
  describe '.app' do
    subject { instance }
    let(:instance) { FbGraph2::Auth.new 'client_id', 'client_secret' }

    it { should be_a Rack::OAuth2::Client }

    describe 'fb_exchange_token grant' do
      it do
        instance.fb_exchange_token = 'short_lived_access_token'
        access_token = mock_graph :post, 'oauth/access_token', 'token_response', params: {
          grant_type: 'fb_exchange_token',
          fb_exchange_token: 'short_lived_access_token',
          client_id: 'client_id',
          client_secret: 'client_secret'
        }, disable_api_versioning: true do
          instance.access_token!
        end
        access_token.should be_instance_of Rack::OAuth2::AccessToken::Legacy
      end
    end
  end
end
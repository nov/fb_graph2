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

    describe '#debug_token!' do
      before do
        mock_graph :post, 'oauth/access_token', 'token_response', params: {
          grant_type: 'client_credentials',
          client_id: 'client_id',
          client_secret: 'client_secret'
        }, disable_api_versioning: true
      end

      context 'when user_token given' do
        subject do
          mock_graph :get, 'debug_token', 'token_metadata/user_token', params: {
            input_token: 'user_token'
          } do
            instance.debug_token! 'user_token'
          end
        end
        it { should be_instance_of FbGraph2::TokenMetadata }
        its(:app) { should be_instance_of FbGraph2::App }
        its(:user) { should be_instance_of FbGraph2::User }
        its(:page) { should be_nil }
      end

      context 'when app_token given' do
        subject do
          mock_graph :get, 'debug_token', 'token_metadata/app_token', params: {
            input_token: 'app_token'
          } do
            instance.debug_token! 'app_token'
          end
        end
        it { should be_instance_of FbGraph2::TokenMetadata }
        its(:app) { should be_instance_of FbGraph2::App }
        its(:user) { should be_nil }
        its(:page) { should be_nil }
      end

      context 'when page_token given' do
        subject do
          mock_graph :get, 'debug_token', 'token_metadata/page_token', params: {
            input_token: 'page_token'
          } do
            instance.debug_token! 'page_token'
          end
        end
        it { should be_instance_of FbGraph2::TokenMetadata }
        its(:app) { should be_instance_of FbGraph2::App }
        its(:user) { should be_instance_of FbGraph2::User }
        its(:page) { should be_instance_of FbGraph2::Page }
      end
    end

    context 'when error occured' do
      it do
        expect do
          mock_graph :post, 'oauth/access_token', 'error/400/191', status: [400, 'Bad Request'], disable_api_versioning: true do
            instance.authorization_code = 'auth_code'
            instance.access_token!
          end
        end.to raise_error(FbGraph2::Exception) do |e|
          e.message.should == 'Missing redirect_uri parameter.'
        end
      end
    end
  end
end
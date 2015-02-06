require 'spec_helper'

describe FbGraph2::Auth do
  subject { instance }
  let(:instance) { FbGraph2::Auth.new 'client_id', 'client_secret' }

  it { should be_a Rack::OAuth2::Client }

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

  describe '#access_token!' do
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

    context 'when fb_exchange_token grant given' do
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

  describe '#from_cookie' do
    let(:token) do
      '9heZHFs6tDH/Nif4CqmBaMQ8nKEOc5g2WgVJa10LF00.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiI4ZDYwZDY4NDA4MmQ1NjczMjY3MWUxNzAuMS01Nzk2MTIyNzZ8N2pkVlp6MlNLNUY2b0gtQ21FQWtZZVpuVjEwIiwiaXNzdWVkX2F0IjoxMzEyOTUzOTcxLCJ1c2VyX2lkIjo1Nzk2MTIyNzZ9'
    end

    it 'should return FbGraph2::Auth::SignedRequest' do
      signed_request = mock_graph :post, 'oauth/access_token', 'token_response', params: {
        grant_type: 'authorization_code',
        code: '8d60d684082d56732671e170.1-579612276|7jdVZz2SK5F6oH-CmEAkYeZnV10',
        client_id: 'client_id',
        client_secret: 'client_secret'
      }, disable_api_versioning: true do
        instance.from_cookie token
      end
      signed_request.should be_instance_of FbGraph2::Auth::SignedRequest
      signed_request.access_token.should be_instance_of Rack::OAuth2::AccessToken::Legacy
      signed_request.access_token.access_token.should == 'access_token'
      signed_request.user.should be_instance_of FbGraph2::User
    end

    context 'when cookie object given' do
      let(:cookie) do
        {'fbsr_client_id' => token}
      end

      it 'should handle it too' do
        signed_request = mock_graph :post, 'oauth/access_token', 'token_response', params: {
          grant_type: 'authorization_code',
          code: '8d60d684082d56732671e170.1-579612276|7jdVZz2SK5F6oH-CmEAkYeZnV10',
          client_id: 'client_id',
          client_secret: 'client_secret'
        }, disable_api_versioning: true do
          instance.from_cookie cookie
        end
        signed_request.should be_instance_of FbGraph2::Auth::SignedRequest
      end
    end
  end

  describe '#from_signed_request' do
    let(:token) do
      'LqsgnfcsRdfjOgyW6ZuSLpGBVsxUBegEqai4EcrWS0A=.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjAsImlzc3VlZF9hdCI6MTI5ODc4MzczOSwib2F1dGhfdG9rZW4iOiIxMzQxNDU2NDMyOTQzMjJ8MmI4YTZmOTc1NTJjNmRjZWQyMDU4MTBiLTU3OTYxMjI3NnxGS1o0akdKZ0JwN2k3bFlrOVhhUk1QZ3lhNnMiLCJ1c2VyIjp7ImNvdW50cnkiOiJqcCIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjU3OTYxMjI3NiJ9'
    end

    it 'should return FbGraph2::Auth::SignedRequest' do
      signed_request = instance.from_signed_request token
      signed_request.should be_instance_of FbGraph2::Auth::SignedRequest
      signed_request.access_token.should == '134145643294322|2b8a6f97552c6dced205810b-579612276|FKZ4jGJgBp7i7lYk9XaRMPgya6s'
      signed_request.user.should be_instance_of FbGraph2::User
    end

    context 'when invalid format' do
      let(:token) { 'invalid.invalid' }

      it do
        expect do
          instance.from_cookie token
        end.to raise_error FbGraph2::Auth::SignedRequest::VerificationFailed
      end
    end

    context 'when signature invalid' do
      let(:token) do
        '4Xnb6TwumZfUQcrflVQHYLOmaWq1oMHbZmI7_pxZXeU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjE0MjMwNDQwMDAsImlzc3VlZF9hdCI6MTQyMzAzNjk3MSwib2F1dGhfdG9rZW4iOiJDQUFDWkN1RXk5ZHBVQkFKUDFJY3BMaThGaU04RnBpcjB2clBmZjhaQXQxblpCSGdyMG9pTUdNVXNBaU9ZZ0F4NkpibkZrMXNJSW95ZjRYMktKSHlVc2ROcmhCd1UwanBoUGFPQzU0bGw4emVMWkFScFZ0b0RYY3FIZE9lNGZjdGVmMHZ5eXdsU0NrTkhIWGdmSDhaQVNUZ1JvQlpCbmRqVHpmQXVtMjFGMFpDdUtZWExDY1pBZ1VEeXJ3d0piekVuYVJybWFxZ2s3VFhOZ3cwZlJaQmVNVVpCM1Q0VG1DMktXU3laQ1laRCIsInRva2VuX2Zvcl9idXNpbmVzcyI6IkFieUR4YVF0cTVPSEVfN04iLCJ1c2VyIjp7ImNvdW50cnkiOiJqcCIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjU3OTYxMjI3NiJ9'
      end

      it do
        expect do
          instance.from_cookie token
        end.to raise_error FbGraph2::Auth::SignedRequest::VerificationFailed
      end
    end
  end
end
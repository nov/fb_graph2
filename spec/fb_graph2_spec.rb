require 'spec_helper'

describe FbGraph2 do
  subject { FbGraph2 }
  after { FbGraph2.debugging = false }

  its(:logger) { should be_a Logger }
  its(:debugging?) { should be_false }

  describe '.debug!' do
    before { FbGraph2.debug! }
    its(:debugging?) { should be_true }
  end

  describe '.http_client' do
    context 'with http_config' do
      before do
        FbGraph2.http_config do |config|
          config.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
          config.connect_timeout = 30
          config.send_timeout    = 40
          config.receive_timeout = 60
        end
      end
      it 'should configure Rack::OAuth2 and FbGraph2 http_client' do
        [Rack::OAuth2, FbGraph2].each do |klass|
          klass.http_client.ssl_config.verify_mode.should == OpenSSL::SSL::VERIFY_NONE
          klass.http_client.connect_timeout.should == 30
          klass.http_client.send_timeout.should    == 40
          klass.http_client.receive_timeout.should == 60
        end
      end
    end
  end
end
require 'spec_helper'

describe FbGraph2::App do
  describe '.app' do
    let(:klass) { FbGraph2::App }

    it 'should not call API' do
      expect do
        app = klass.app 'token'
        app.should be_instance_of klass
      end.not_to request_to 'app'
    end

    context 'when fetched' do
      it 'should call API' do
        app = mock_graph :get, 'app', 'app/app' do
          klass.app('token').fetch
        end
        app.should be_instance_of klass
      end
    end
  end
end
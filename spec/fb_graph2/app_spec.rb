require 'spec_helper'

describe FbGraph2::App do
  describe '.app' do
    it 'should not call API' do
      expect do
        app = described_class.app 'token'
        app.should be_instance_of described_class
      end.not_to request_to 'app'
    end

    context 'when fetched' do
      it 'should call API' do
        app = mock_graph :get, 'app', 'app/app' do
          described_class.app('token').fetch
        end
        app.should be_instance_of described_class
      end
    end
  end
end
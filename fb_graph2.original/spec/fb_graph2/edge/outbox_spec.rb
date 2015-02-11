require 'spec_helper'

describe FbGraph2::Edge::Outbox do
  context 'included in User' do
    describe '#outbox' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Thread' do
        threads = mock_graph :get, 'me/outbox', 'user/outbox', access_token: 'token' do
          me.outbox
        end
        threads.should be_instance_of FbGraph2::Edge
        threads.should_not be_blank
        threads.each do |thread|
          thread.should be_instance_of FbGraph2::Thread
        end
      end
    end
  end
end
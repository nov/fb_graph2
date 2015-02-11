require 'spec_helper'

describe FbGraph2::Edge::Inbox do
  context 'included in User' do
    describe '#inbox' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Thread' do
        threads = mock_graph :get, 'me/inbox', 'user/inbox', access_token: 'token' do
          me.inbox
        end
        threads.should be_instance_of FbGraph2::Edge
        threads.should_not be_blank
        threads.each do |thread|
          thread.should be_instance_of FbGraph2::Thread
        end
        threads.summary.should include unseen_count: 0, unread_count: 0, updated_time: Time.parse('2014-09-02T03:51:40+0000')
      end
    end
  end
end
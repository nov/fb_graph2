require 'spec_helper'

describe FbGraph2::Edge::Conversations do
  context 'included in Page' do
    describe '#conversations' do
      let(:page) { FbGraph2::Page.new('page_id').authenticate('token') }
      it 'should return an Array of FbGraph2::Messages' do
        conversations = mock_graph :get, 'page_id/conversations', 'page/conversations', access_token: 'token' do
          page.conversations
        end
        conversations.should be_instance_of FbGraph2::Edge
        conversations.should_not be_blank
        conversations.each do |message|
          message.should be_instance_of FbGraph2::Message
        end
      end
    end
  end
end

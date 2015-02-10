require 'spec_helper'

describe FbGraph2::Edge::Messages do
  context 'included in Conversation' do
    describe '#messages' do
      let(:conversation) { FbGraph2::Conversation.new('conversation_id').authenticate('token') }
      it 'should return an Array of FbGraph2::Message' do
        messages = mock_graph :get, 'conversation_id/messages', 'conversation/messages', access_token: 'token' do
          conversation.messages
        end
        messages.should be_instance_of FbGraph2::Edge
        messages.should_not be_blank
        messages.each do |message|
          message.should be_instance_of FbGraph2::Message
        end
      end
    end
  end
end

require 'spec_helper'

describe FbGraph2::Edge::Messages do
  context 'Messages' do
    let(:conversation) { FbGraph2::Conversation.new("conversation_id").authenticate('token') }

    describe '#messages' do
      it 'should return an Array of authenticated FbGraph2::Message objects' do

        messages = mock_graph :get, 'conversation_id/messages', 'conversation/messages', access_token: 'token' do
          conversation.messages
        end

        expect(messages.first.access_token).to eq('token')

      end
    end
  end
end

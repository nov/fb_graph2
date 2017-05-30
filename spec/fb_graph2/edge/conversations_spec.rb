require 'spec_helper'

describe FbGraph2::Edge::Conversations do
  context 'Conversations' do
    let(:page) { FbGraph2::Page.new("page_id").authenticate('token') }

    describe '#conversations' do
      it 'should return an Array of authenticated FbGraph2::Conversation objects' do

        conversations = mock_graph :get, 'page_id/conversations', 'page/conversations', access_token: 'token' do
          page.conversations
        end

        conversations.each { |conversation| expect(conversation.access_token).to eq('token') }

      end
    end
  end
end

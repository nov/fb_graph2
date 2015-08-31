require 'spec_helper'

describe FbGraph2::Edge::OpenGraph::Actions do
  context 'included in User' do
    describe '#og_actions' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Post' do
        actions = mock_graph :get, 'me/og.likes', 'user/og_actions_likes', access_token: 'token' do
          me.og_actions 'og.likes'
        end
        actions.should be_instance_of FbGraph2::Edge
        actions.should_not be_blank
        actions.each do |action|
          action.should be_instance_of FbGraph2::OpenGraph::Action
        end
      end
    end

    describe '#og_action!' do
      let(:user) { FbGraph2::User.new('user_id') }
      it 'should return a FbGraph2::Post' do
        mock_graph :post, 'user_id/og.likes', 'success_with_id', access_token: 'app_token' do
          user.authenticate('app_token').og_action! 'og.likes', object: 'https://github.com/nov/fb_graph2/'
        end.should be_instance_of FbGraph2::OpenGraph::Action
      end
    end
  end
end

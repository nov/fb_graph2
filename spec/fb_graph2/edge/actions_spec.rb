require 'spec_helper'

describe FbGraph2::Edge::Actions do
  context 'included in User' do
    describe '#actions' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'me/og.likes', 'user/actions_og_likes', access_token: 'token' do
          me.actions 'og.likes'
        end
        posts.should be_instance_of FbGraph2::Edge
        posts.should_not be_blank
        posts.each do |post|
          post.should be_instance_of FbGraph2::Post
        end
      end
    end

    describe '#action!' do
      let(:user) { FbGraph2::User.new('user_id') }
      it 'should return a FbGraph2::Post' do
        mock_graph :post, 'user_id/og.likes', 'success_with_id', access_token: 'app_token' do
          user.authenticate('app_token').action! 'og.likes', object: 'https://github.com/nov/fb_graph2/'
        end.should be_instance_of FbGraph2::Post
      end
    end
  end
end

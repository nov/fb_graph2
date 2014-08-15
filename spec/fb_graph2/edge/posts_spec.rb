require 'spec_helper'

describe FbGraph2::Edge::Posts do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }
    describe '#posts' do
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'me/posts', 'user/posts', access_token: 'token' do
          me.posts
        end
        posts.should be_instance_of FbGraph2::Edge
        posts.should_not be_blank
        posts.each do |post|
          post.should be_instance_of FbGraph2::Post
        end
      end
    end
  end
end
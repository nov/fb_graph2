require 'spec_helper'

describe FbGraph2::Edge::SharedPosts do
  context 'included in Post' do
    describe '#shared_posts' do
      let(:post) { FbGraph2::Post.new('post_id').authenticate('token') }
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'post_id/sharedposts', 'post/shared_posts', access_token: 'token' do
          post.shared_posts
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
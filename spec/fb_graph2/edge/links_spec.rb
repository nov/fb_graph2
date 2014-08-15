require 'spec_helper'

describe FbGraph2::Edge::Links do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }
    describe '#links' do
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'me/links', 'user/links', access_token: 'token' do
          me.links
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
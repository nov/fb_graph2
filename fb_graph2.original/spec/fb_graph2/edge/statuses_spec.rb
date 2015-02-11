require 'spec_helper'

describe FbGraph2::Edge::Statuses do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }
    describe '#statuses' do
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'me/statuses', 'user/statuses', access_token: 'token' do
          me.statuses
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
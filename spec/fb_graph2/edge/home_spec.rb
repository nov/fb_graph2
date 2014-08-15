require 'spec_helper'

describe FbGraph2::Edge::Feed do
  context 'included in User' do
    describe '#home' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'me/home', 'user/home', access_token: 'token' do
          me.home
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
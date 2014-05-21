require 'spec_helper'

describe FbGraph2::Edge::Feed do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#feed' do
      it :TODO
    end

    describe 'feed!' do
      it 'should return FbGraph2::Post with posted params' do
        post = mock_graph :post, 'me/feed', 'success_with_id', access_token: 'token' do
          me.feed! message: 'hello'
        end
        post.should be_instance_of FbGraph2::Post
        post.id.should == 'created_object_id'
        post.message.should == 'hello'
      end
    end
  end
end
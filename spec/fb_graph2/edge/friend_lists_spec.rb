require 'spec_helper'

describe FbGraph2::Edge::FriendLists do
  context 'included in User' do
    describe '#friend_lists' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::FriendList' do
        friend_lists = mock_graph :get, 'me/friendlists', 'user/friend_lists', access_token: 'token' do
          me.friend_lists
        end
        friend_lists.should be_instance_of FbGraph2::Edge
        friend_lists.should_not be_blank
        friend_lists.each do |friend_list|
          friend_list.should be_instance_of FbGraph2::FriendList
        end
      end
    end
  end
end
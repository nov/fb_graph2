require 'spec_helper'

describe FbGraph2::Edge::InvitableFriends do
  context 'included in User' do
    describe '#invitable_friends' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Struct::InvitableFriend' do
        users = mock_graph :get, 'me/invitable_friends', 'user/invitable_friends', access_token: 'token' do
          me.invitable_friends
        end
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::Struct::InvitableFriend
        end
      end
    end
  end
end
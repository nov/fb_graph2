require 'spec_helper'

describe FbGraph2::Edge::InvitableFriends do
  context 'included in User' do
    describe '#invitable_friends' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Struct::Friend' do
        users = mock_graph :get, 'me/invitable_friends', 'user/invitable_friends', access_token: 'token' do
          me.invitable_friends
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::Struct::Friend
        end
      end
    end
  end
end
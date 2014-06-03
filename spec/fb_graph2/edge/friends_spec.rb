require 'spec_helper'

describe FbGraph2::Edge::Friends do
  context 'included in User' do
    describe '#friends' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'me/friends', 'user/friends', access_token: 'token' do
          me.friends
        end
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end
  end
end
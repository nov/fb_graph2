require 'spec_helper'

describe FbGraph2::Edge::Friends do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#friends' do
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'me/friends', 'user/friends', access_token: 'token' do
          me.friends
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end

    describe '#friend?' do
      context 'when is friend' do
        it do
          mock_graph :get, 'me/friends/user_id', 'user/friends', access_token: 'token' do
            me.friend? 'user_id'
          end.should be true
        end
      end

      context 'otherwise' do
        it do
          mock_graph :get, 'me/friends/user_id', 'blank_collection', access_token: 'token' do
            me.friend? 'user_id'
          end.should be false
        end
      end
    end
  end
end
require 'spec_helper'

describe FbGraph2::Edge::Members do
  context 'included in Group' do
    let(:group) { FbGraph2::Group.new('group_id').authenticate('token') }

    describe '#invited' do
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'group_id/members', 'group/members', access_token: 'token' do
          group.members
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
        users.last.administrator.should be true
      end
    end
  end
end
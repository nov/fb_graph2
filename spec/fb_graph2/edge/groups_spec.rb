require 'spec_helper'

describe FbGraph2::Edge::Groups do
  context 'included in User' do
    describe '#groups' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Page' do
        groups = mock_graph :get, 'me/groups', 'user/groups', access_token: 'token' do
          me.groups
        end
        groups.should be_instance_of FbGraph2::Edge
        groups.should_not be_blank
        groups.each do |group|
          group.should be_instance_of FbGraph2::Group
        end
      end
    end
  end
end
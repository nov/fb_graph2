require 'spec_helper'

describe FbGraph2::Edge::Permissions do
  context 'included in User' do
    describe '#permissions' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Struct::Permission' do
        permissions = mock_graph :get, 'me/permissions', 'user/permissions', access_token: 'token' do
          me.permissions
        end
        permissions.should be_instance_of FbGraph2::Edge
        permissions.should_not be_blank
        permissions.each do |permission|
          permission.should be_instance_of FbGraph2::Struct::Permission
        end
      end
    end
  end
end
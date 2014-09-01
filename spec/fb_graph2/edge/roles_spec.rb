require 'spec_helper'

describe FbGraph2::Edge::Roles do
  context 'included in App' do
    let(:app) { FbGraph2::App.app('app_token') }

    describe '#roles' do
      it 'should return an Array of FbGraph2::Struct::Role' do
        roles = mock_graph :get, 'app/roles', 'app/roles', access_token: 'app_token' do
          app.roles
        end
        roles.should be_instance_of FbGraph2::Edge
        roles.should_not be_blank
        roles.each do |role|
          role.should be_instance_of FbGraph2::Struct::Role
        end
      end
    end
  end
end
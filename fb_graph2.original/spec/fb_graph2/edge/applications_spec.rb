require 'spec_helper'

describe FbGraph2::Edge::Applications do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#applications' do
      it 'should return an Array of FbGraph2::App' do
        apps = mock_graph :get, 'me/applications/developer', 'user/applications', access_token: 'token' do
          me.applications
        end
        apps.should be_instance_of FbGraph2::Edge
        apps.should_not be_blank
        apps.each do |app|
          app.should be_instance_of FbGraph2::App
        end
      end
    end
  end
end
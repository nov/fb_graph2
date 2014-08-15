require 'spec_helper'

describe FbGraph2::Edge::TestUsers do
  context 'included in App' do
    describe '#test_users' do
      let(:app) { FbGraph2::App.app('app_token') }
      it 'should return an Array of FbGraph2::User with test_user token' do
        users = mock_graph :get, 'app/accounts/test-users', 'app/test_users', access_token: 'app_token' do
          app.test_users
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
          user.access_token.should == 'test_user_token'
        end
      end
    end
  end
end
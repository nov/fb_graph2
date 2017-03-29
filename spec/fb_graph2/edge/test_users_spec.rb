require 'spec_helper'

describe FbGraph2::Edge::TestUsers do
  context 'included in App' do
    let(:app) { FbGraph2::App.app('app_token') }

    describe '#test_users' do
      it 'should return an Array of FbGraph2::TestUser with test_user token' do
        users = mock_graph :get, 'app/accounts/test-users', 'app/test_users', access_token: 'app_token' do
          app.test_users
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::TestUser
          user.access_token.should == 'test_user_token'
        end
      end
    end

    describe '#test_user!' do
      it 'should create an Object of FbGraph2::TestUser with test_user token' do
        permissions = %w[public_profile,email,user_friends].join(',')
        user = mock_graph :post, 'app/accounts/test-users', 'post/test_users', access_token: 'app_token', permissions: permissions do
          app.test_user!
        end
        user.should be_instance_of FbGraph2::TestUser
        user.access_token.should == 'test_user_token'
      end
    end
  end
end

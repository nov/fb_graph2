require 'spec_helper'

describe FbGraph2::TestUser do
  let(:app) { FbGraph2::App.app('app_token') }

  let(:test_user) do
    permissions = %w[public_profile,email,user_friends].join(',')
    mock_graph :post, 'app/accounts/test-users', 'post/test_users', access_token: 'app_token', permissions: permissions do
      app.test_user!
    end
  end

  describe '#access_token' do
    it 'should provide the TestUser access token' do
      test_user.access_token.should == 'test_user_token'
    end
  end

  describe '#password' do
    it 'should provide the new test user password' do
      test_user.password.should == 'test_user_password'
    end
  end

  describe '#login_url' do
    it 'should provide the new test user login_url' do
      test_user.login_url.should == 'https://developers.facebook.com/checkpoint/test-user-login/106444709796298/'
    end
  end

  describe '#friend!' do
    let(:test_friend) { FbGraph2::TestUser.new('123456789') }

    it 'should request and confirm the friendship for the given test user' do
      mock_graph :post, "#{test_user.id}/friends/#{test_friend.id}", 'success_true', access_token: test_user.access_token
      mock_graph :post, "#{test_friend.id}/friends/#{test_user.id}", 'success_true', access_token: test_friend.access_token
      test_user.friend!(test_friend)
    end
  end
end

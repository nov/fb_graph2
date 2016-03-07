require 'spec_helper'

describe FbGraph2::Edge::TestUser do
  context 'included in App' do
    describe '#test_user' do
      let(:app) { FbGraph2::App.app('app_token') }
      it 'should return a new user' do
        new_user_arr = mock_graph :post, 'app/accounts/test-users', 'app/test_user', access_token: 'app_token' do
          app.test_user
        end
        new_user_arr.should be_instance_of FbGraph2::Edge
        new_user = new_user_arr.first
        new_user.should_not be_blank
        new_user.should be_instance_of FbGraph2::User
        new_user.access_token.should == 'test_user_token'
      end
    end
  end
end

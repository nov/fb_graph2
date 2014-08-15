require 'spec_helper'

describe FbGraph2::Edge::Accounts do
  context 'included in User' do
    describe '#accounts' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Page with page token' do
        accounts = mock_graph :get, 'me/accounts', 'user/accounts', access_token: 'token' do
          me.accounts
        end
        accounts.should be_instance_of FbGraph2::Edge
        accounts.should_not be_blank
        accounts.each do |account|
          account.should be_instance_of FbGraph2::Page
          account.access_token.should == 'page_token'
        end
        accounts.first.name.should == 'Identity Conference #idcon'
      end
    end
  end
end
require 'spec_helper'

describe FbGraph2::Edge::Accounts do
  context 'included in User' do
    describe '#accounts' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return pages with page token' do
        accounts = mock_graph :get, 'me/accounts', 'user/accounts' do
          me.accounts
        end
        account = accounts.first
        account.should be_instance_of FbGraph2::Page
        account.name.should == 'Identity Conference #idcon'
        account.access_token.should == 'page_token'
      end
    end
  end
end
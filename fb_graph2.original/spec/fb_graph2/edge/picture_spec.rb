require 'spec_helper'

describe FbGraph2::Edge::Picture do
  context 'included in User' do
    describe '#picture' do
      let(:me) { FbGraph2::User.me('token') }
      it do
        mock_graph :get, 'me/picture', 'user/picture', access_token: 'token', params: {
          redirect: false
        } do
          me.picture
        end.should be_instance_of FbGraph2::Struct::Picture
      end
    end
  end
end
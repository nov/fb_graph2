require 'spec_helper'

describe FbGraph2::Edge::Pokes do
  context 'included in User' do
    describe '#pokes' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Struct::Poke' do
        pokes = mock_graph :get, 'me/pokes', 'user/pokes', access_token: 'token' do
          me.pokes
        end
        pokes.should be_instance_of FbGraph2::Edge
        pokes.should_not be_blank
        pokes.each do |poke|
          poke.should be_instance_of FbGraph2::Struct::Poke
        end
      end
    end
  end
end
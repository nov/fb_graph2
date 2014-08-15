require 'spec_helper'

describe FbGraph2::Edge::Music do
  context 'included in User' do
    describe '#music' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Page' do
        pages = mock_graph :get, 'me/music', 'user/music', access_token: 'token' do
          me.music
        end
        pages.should be_instance_of FbGraph2::Edge
        pages.should_not be_blank
        pages.each do |page|
          page.should be_instance_of FbGraph2::Page
        end
      end
    end
  end
end
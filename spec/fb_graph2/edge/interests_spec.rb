require 'spec_helper'

describe FbGraph2::Edge::Interests do
  context 'included in User' do
    describe '#interests' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Page' do
        pages = mock_graph :get, 'me/interests', 'user/interests', access_token: 'token' do
          me.interests
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
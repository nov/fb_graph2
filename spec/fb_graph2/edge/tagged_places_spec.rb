require 'spec_helper'

describe FbGraph2::Edge::TaggedPlaces do
  context 'included in User' do
    describe '#tagged_places' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::PlaceTag' do
        tags = mock_graph :get, 'me/tagged_places', 'user/tagged_places', access_token: 'token' do
          me.tagged_places
        end
        tags.should be_instance_of FbGraph2::Edge
        tags.should_not be_blank
        tags.each do |tag|
          tag.should be_instance_of FbGraph2::PlaceTag
          tag.place.should be_instance_of FbGraph2::Place
          tag.place.location.should be_instance_of FbGraph2::Struct::Location
        end
      end
    end
  end
end
require 'spec_helper'

describe FbGraph2::Edge::Photos do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#photos' do
      it 'should return an Array of FbGraph2::Photo' do
        photos = mock_graph :get, 'me/photos', 'user/photos', access_token: 'token' do
          me.photos
        end
        photos.should be_instance_of FbGraph2::Edge
        photos.should_not be_blank
        photos.each do |photo|
          photo.should be_instance_of FbGraph2::Photo
        end
      end
    end

    describe 'photo!' do
      it 'should return FbGraph2::Post' do
        photo = mock_graph :post, 'me/photos', 'success_with_id', access_token: 'token' do
          me.photo! url: 'http://example.com/me.png'
        end
        photo.should be_instance_of FbGraph2::Photo
        photo.id.should == 'created_object_id'
      end
    end
  end
end
require 'spec_helper'

describe FbGraph2::Edge::Albums do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#albums' do
      it 'should return an Array of FbGraph2::Video' do
        albums = mock_graph :get, 'me/albums', 'user/albums', access_token: 'token' do
          me.albums
        end
        albums.should be_instance_of FbGraph2::Edge
        albums.should_not be_blank
        albums.each do |album|
          album.should be_instance_of FbGraph2::Album
        end
      end
    end

    describe '#album!' do
      it do
        album = mock_graph :post, 'me/albums', 'success_with_id', access_token: 'token', params: {
          name: 'test'
        } do
          me.album! name: 'test'
        end
        album.should be_instance_of FbGraph2::Album
      end
    end
  end
end
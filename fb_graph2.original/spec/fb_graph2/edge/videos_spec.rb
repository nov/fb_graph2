require 'spec_helper'

describe FbGraph2::Edge::Videos do
  context 'included in User' do
    let(:me) { FbGraph2::User.me('token') }

    describe '#videos' do
      it 'should return an Array of FbGraph2::Video' do
        videos = mock_graph :get, 'me/videos', 'user/videos', access_token: 'token' do
          me.videos
        end
        videos.should be_instance_of FbGraph2::Edge
        videos.should_not be_blank
        videos.each do |video|
          video.should be_instance_of FbGraph2::Video
        end
      end
    end

    describe '#video!' do
      it do
        video = mock_graph :post, 'me/videos', 'success_with_id', access_token: 'token' do
          me.video! source: File.new(__FILE__), message: 'hello'
        end
        video.should be_instance_of FbGraph2::Video
      end
    end
  end
end
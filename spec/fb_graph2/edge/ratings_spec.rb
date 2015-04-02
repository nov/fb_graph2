require 'spec_helper'

describe FbGraph2::Edge::Ratings do
  let(:page) { FbGraph2::Page.new('page_id').authenticate('page_token') }

  describe '#ratings' do
    it 'should return an Array of FbGraph2::Struct::Rating' do
      ratings = mock_graph :get, 'page_id/ratings', 'page/ratings', access_token: 'page_token' do
        page.ratings
      end
      ratings.should be_instance_of FbGraph2::Edge
      ratings.should_not be_blank
      ratings.each do |rating|
        rating.should be_instance_of FbGraph2::Struct::Rating
      end
    end
  end
end

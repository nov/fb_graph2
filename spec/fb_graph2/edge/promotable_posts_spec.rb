require 'spec_helper'

describe FbGraph2::Edge::PromotablePosts do
  context 'included in Page' do
    describe '#promotable_posts' do
      let(:page) { FbGraph2::Page.new('page_id').authenticate('page_token') }
      it 'should return an Array of FbGraph2::Post' do
        posts = mock_graph :get, 'page_id/promotable_posts', 'page/promotable_posts', access_token: 'page_token' do
          page.promotable_posts
        end
        posts.should be_instance_of FbGraph2::Edge
        posts.should_not be_blank
        posts.each do |post|
          post.should be_instance_of FbGraph2::Post
        end
      end
    end
  end
end
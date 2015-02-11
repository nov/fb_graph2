require 'spec_helper'

describe FbGraph2::Edge::Blocked do
  context 'included in Page' do
    let(:page)    { FbGraph2::Page.new('page_id').authenticate('page_token') }
    let(:user_id) { 'user_id' }
    let(:user)    { FbGraph2::User.new(user_id) }

    describe '#blocked' do
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'page_id/blocked', 'page/blocked', access_token: 'page_token' do
          page.blocked
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end

    describe '#blocked?' do
      context 'when String given' do
        it do
          mock_graph :get, "page_id/blocked/#{user_id}", 'page/blocked', access_token: 'page_token' do
            page.blocked? user_id
          end.should be true
        end
      end

      context 'when FbGraph2::User given' do
        it do
          mock_graph :get, "page_id/blocked/#{user_id}", 'page/blocked', access_token: 'page_token' do
            page.blocked? user
          end.should be true
        end
      end
    end

    describe '#block!' do
      it do
        result = mock_graph :post, 'page_id/blocked', 'page/block_succeeded', access_token: 'page_token', params: {
          user: user_id
        } do
          page.block! user
        end
        result.should == {'user_id' => true}
      end
    end

    describe '#unblock!' do
      it do
        mock_graph :delete, 'page_id/blocked', 'true', access_token: 'page_token', params: {
          user: user_id
        } do
          page.unblock! user
        end.should be true
      end
    end
  end
end
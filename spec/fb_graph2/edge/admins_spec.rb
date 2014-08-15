require 'spec_helper'

describe FbGraph2::Edge::Admins do
  context 'included in Page' do
    let(:page) { FbGraph2::Page.new('page_id').authenticate('page_token') }

    describe '#admins' do
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'page_id/admins', 'page/admins', access_token: 'page_token' do
          page.admins
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end

    describe '#admin?' do
      let(:user_id) { 'user_id' }
      let(:user)    { FbGraph2::Page.new(user_id) }

      context 'when String given' do
        it do
          mock_graph :get, "page_id/admins/#{user_id}", 'page/admins', access_token: 'page_token' do
            page.admin? user_id
          end.should be true
        end
      end

      context 'when FbGraph2::User given' do
        it do
          mock_graph :get, "page_id/admins/#{user_id}", 'page/admins', access_token: 'page_token' do
            page.admin? user
          end.should be true
        end
      end
    end
  end
end
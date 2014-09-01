require 'spec_helper'

describe FbGraph2::Edge::Banned do
  context 'included in App' do
    let(:app)     { FbGraph2::App.app('app_token') }
    let(:user_id) { 'user_id' }
    let(:user)    { FbGraph2::User.new(user_id) }

    describe '#banned' do
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'app/banned', 'app/banned', access_token: 'app_token' do
          app.banned
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end

    describe '#banned?' do
      context 'when String given' do
        it do
          mock_graph :get, "app/banned/#{user_id}", 'app/banned', access_token: 'app_token' do
            app.banned? user_id
          end.should be true
        end
      end

      context 'when FbGraph2::User given' do
        it do
          mock_graph :get, "app/banned/#{user_id}", 'app/banned', access_token: 'app_token' do
            app.banned? user
          end.should be true
        end
      end
    end

    describe '#ban!' do
      it do
        mock_graph :post, 'app/banned', 'true', access_token: 'app_token', params: {
          uid: user_id
        } do
          app.ban! user
        end.should be true
      end
    end

    describe '#unban!' do
      it do
        mock_graph :delete, 'app/banned', 'true', access_token: 'app_token', params: {
          uid: user_id
        } do
          app.unban! user
        end.should be true
      end
    end
  end
end
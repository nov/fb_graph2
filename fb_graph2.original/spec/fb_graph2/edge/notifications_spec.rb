require 'spec_helper'

describe FbGraph2::Edge::Notifications do
  context 'included in User' do
    describe '#notifications' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Notification' do
        notifications = mock_graph :get, 'me/notifications', 'user/notifications', access_token: 'token' do
          me.notifications
        end
        notifications.should be_instance_of FbGraph2::Edge
        notifications.should_not be_blank
        notifications.each do |notification|
          notification.should be_instance_of FbGraph2::Notification
        end
      end
    end

    describe '#notification!' do
      let(:user) { FbGraph2::User.new('user_id') }
      it 'should return true' do
        mock_graph :post, 'user_id/notifications', 'success_true', access_token: 'app_token', params: {
          href: 'href', template: 'template'
        } do
          user.authenticate('app_token').notification! href: 'href', template: 'template'
        end.should be true
      end
    end
  end
end
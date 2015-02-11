require 'spec_helper'

describe FbGraph2::Edge::Subscriptions do
  context 'included in App' do
    describe '#subscriptions' do
      let(:app) { FbGraph2::App.app('app_token') }
      it 'should return an Array of FbGraph2::Struct::Subscription' do
        subscriptions = mock_graph :get, 'app/subscriptions', 'app/subscriptions', access_token: 'app_token' do
          app.subscriptions
        end
        subscriptions.should be_instance_of FbGraph2::Edge
        subscriptions.should_not be_blank
        subscriptions.each do |subscription|
          subscription.should be_instance_of FbGraph2::Struct::Subscription
        end
      end
    end
  end
end
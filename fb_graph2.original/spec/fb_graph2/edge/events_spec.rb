require 'spec_helper'

describe FbGraph2::Edge::Events do
  context 'included in User' do
    describe '#events' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Event' do
        events = mock_graph :get, 'me/events', 'user/events', access_token: 'token' do
          me.events
        end
        events.should be_instance_of FbGraph2::Edge
        events.should_not be_blank
        events.each do |event|
          event.should be_instance_of FbGraph2::Event
        end
      end
    end
  end
end
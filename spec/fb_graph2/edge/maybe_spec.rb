require 'spec_helper'

describe FbGraph2::Edge::Maybe do
  context 'included in Event' do
    let(:event) { FbGraph2::Event.new('event_id').authenticate('token') }

    describe '#maybe' do
      it 'should return an Array of FbGraph2::User' do
        users = mock_graph :get, 'event_id/maybe', 'event/maybe', access_token: 'token' do
          event.maybe
        end
        users.should be_instance_of FbGraph2::Edge
        users.should_not be_blank
        users.each do |user|
          user.should be_instance_of FbGraph2::User
        end
      end
    end
  end
end
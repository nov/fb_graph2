require 'spec_helper'

describe FbGraph2::Edge::Scores do
  context 'included in User' do
    describe '#scores' do
      let(:me) { FbGraph2::User.me('token') }
      it 'should return an Array of FbGraph2::Struct::Score' do
        scores = mock_graph :get, 'me/scores', 'user/scores', access_token: 'token' do
          me.scores
        end
        scores.should be_instance_of FbGraph2::Edge
        scores.should_not be_blank
        scores.each do |score|
          score.should be_instance_of FbGraph2::Struct::Score
        end
      end
    end
  end
end
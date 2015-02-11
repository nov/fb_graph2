require 'spec_helper'

describe FbGraph2::Edge::Milestones do
  context 'included in Page' do
    describe '#milestones' do
      let(:page) { FbGraph2::Page.new('page_id').authenticate('token') }
      it 'should return an Array of FbGraph2::Milestone' do
        milestones = mock_graph :get, 'page_id/milestones', 'page/milestones', access_token: 'token' do
          page.milestones
        end
        milestones.should be_instance_of FbGraph2::Edge
        milestones.should_not be_blank
        milestones.each do |milestone|
          milestone.should be_instance_of FbGraph2::Milestone
        end
      end
    end
  end
end
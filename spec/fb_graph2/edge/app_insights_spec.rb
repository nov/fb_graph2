require 'spec_helper'

describe FbGraph2::Edge::AppInsights do
  let(:app) { FbGraph2::App.app('app_token') }

  describe '#app_link_hosts' do
    it 'should return an Array of FbGraph2::AppInsight' do
      mock_graph :get, 'app/app_insights/metric', 'app/app_insights', access_token: 'app_token' do
        insights = app.app_insights('metric')
        insights.should be_instance_of FbGraph2::Edge
        insights.should_not be_blank
        insights.each do |host|
          host.should be_instance_of FbGraph2::Struct::AppInsight
        end
      end
    end
  end

end

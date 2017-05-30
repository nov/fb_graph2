module FbGraph2
  class Edge
    module Insights
      def insights(params = {})
        insights = self.edge :insights, params.except(:metrics), edge_scope: params[:metrics]
        insights.collect! do |insight|
          Insight.new(insight[:id], insight).authenticate self.access_token
        end
      end
    end
  end
end
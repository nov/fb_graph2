module FbGraph2
  class Edge
    module AppInsights
      def app_insights(metric, params = {})
        insights = self.edge :app_insights, params, { edge_scope: metric }
        insights.collect! do |insight|
          FbGraph2::Struct::AppInsight.new insight
        end
      end
    end
  end
end

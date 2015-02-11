module FbGraph2
  class Edge
    module Milestones
      def milestones(params = {})
        milestones = self.edge :milestones, params
        milestones.collect! do |milestone|
          Milestone.new(milestone[:id], milestone).authenticate self.access_token
        end
      end
    end
  end
end
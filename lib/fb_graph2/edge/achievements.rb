module FbGraph2
  class Edge
    module Achievements
      def achievements(params = {})
        achievements = self.edge :achievements, params
        achievements.collect! do |achievement|
          Achievement.new(achievement[:id], achievement).authenticate self.access_token
        end
      end
    end
  end
end
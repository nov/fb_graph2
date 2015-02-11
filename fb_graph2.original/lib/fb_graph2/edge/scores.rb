module FbGraph2
  class Edge
    module Scores
      def scores(params = {})
        scores = self.edge :scores, params
        scores.collect! do |score|
          Struct::Score.new score
        end
      end
    end
  end
end
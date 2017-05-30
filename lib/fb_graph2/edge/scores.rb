module FbGraph2
  class Edge
    module Scores
      def scores(params = {})
        scores = self.edge :scores, params
        scores.collect! do |score|
          Struct::Score.new score
        end
      end

      def score!(score, params = {})
        self.post params.merge(score: score), edge: :scores
      end

      def unscore!(params = {})
        self.delete params, edge: :scores
      end
    end
  end
end
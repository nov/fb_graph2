module FbGraph2
  class Edge
    module Ratings
      def ratings(params = {})
        ratings = self.edge :ratings, params
        ratings.collect! do |rating|
          Struct::Rating.new rating
        end
      end
    end
  end
end

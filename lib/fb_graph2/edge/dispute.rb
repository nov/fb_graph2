module FbGraph2
  class Edge
    module Dispute
      def dispute!(params = {})
        self.post params, edge: :dispute
      end
    end
  end
end
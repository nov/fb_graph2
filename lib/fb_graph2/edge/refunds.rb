module FbGraph2
  class Edge
    module Refunds
      def refund!(params = {})
        self.post params, edge: :refund
      end
    end
  end
end
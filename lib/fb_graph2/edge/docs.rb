module FbGraph2
  class Edge
    module Docs
      def docs(params = {})
        docs = self.edge :docs, params
        docs.collect! do |doc|
          GroupDoc.new(doc[:id], doc).authenticate self.access_token
        end
      end
    end
  end
end
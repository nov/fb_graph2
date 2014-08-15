module FbGraph2
  class Edge
    module Interests
      def interests(params = {})
        pages = self.edge :interests, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
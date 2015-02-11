module FbGraph2
  class Edge
    module Locations
      def locations(params = {})
        pages = self.edge :locations, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end

      # TODO: add, delete and update locations
    end
  end
end
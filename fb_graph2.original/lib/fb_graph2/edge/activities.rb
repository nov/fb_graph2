module FbGraph2
  class Edge
    module Activities
      def activities(params = {})
        pages = self.edge :activities, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
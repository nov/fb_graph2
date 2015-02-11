module FbGraph2
  class Edge
    module Games
      def games(params = {})
        pages = self.edge :games, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
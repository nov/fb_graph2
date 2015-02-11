module FbGraph2
  class Edge
    module Movies
      def movies(params = {})
        pages = self.edge :movies, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
module FbGraph2
  class Edge
    module Books
      def books(params = {})
        pages = self.edge :books, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
module FbGraph2
  class Edge
    module Music
      def music(params = {})
        pages = self.edge :music, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
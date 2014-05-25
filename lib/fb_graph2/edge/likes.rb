module FbGraph2
  class Edge
    module Likes
      def likes(params = {})
        pages = self.edge :likes, params
        pages.collect do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end

      def liked?(page_id, params = {})
        pages = self.edge :likes, params, edge_scope: page_id
        pages.present?
      end
    end
  end
end
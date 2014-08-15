module FbGraph2
  class Edge
    module GlobalBrandChildren
      def global_brand_children(params = {})
        pages = self.edge :global_brand_children, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
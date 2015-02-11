module FbGraph2
  class Edge
    module Television
      def television(params = {})
        pages = self.edge :television, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate self.access_token
        end
      end
    end
  end
end
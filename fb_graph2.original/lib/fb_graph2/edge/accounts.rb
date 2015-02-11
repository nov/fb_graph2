module FbGraph2
  class Edge
    module Accounts
      def accounts(params = {})
        pages = self.edge :accounts, params
        pages.collect! do |page|
          Page.new(page[:id], page).authenticate page[:access_token]
        end
      end
    end
  end
end
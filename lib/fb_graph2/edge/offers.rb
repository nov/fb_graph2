module FbGraph2
  class Edge
    module Offers
      def offers(params = {})
        offers = self.edge :offers, params
        offers.collect! do |offer|
          Offer.new(offer[:id], offer).authenticate self.access_token
        end
      end
    end
  end
end
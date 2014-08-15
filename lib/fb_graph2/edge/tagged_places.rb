module FbGraph2
  class Edge
    module TaggedPlaces
      def tagged_places(params = {})
        place_tags = self.edge :tagged_places, params
        place_tags.collect! do |place_tag|
          PlaceTag.new(place_tag[:id], place_tag).authenticate self.access_token
        end
      end
    end
  end
end
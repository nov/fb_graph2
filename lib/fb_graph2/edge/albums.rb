module FbGraph2
  class Edge
    module Albums
      def albums(params = {})
        albums = self.edge :albums, params
        albums.collect! do |album|
          Album.new(album[:id], album).authenticate self.access_token
        end
      end

      def album!(params = {})
        album = self.post params, edge: :albums
        Album.new(album[:id], params.merge(album)).authenticate self.access_token
      end
    end
  end
end
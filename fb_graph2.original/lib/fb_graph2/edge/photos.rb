module FbGraph2
  class Edge
    module Photos
      def photos(*args)
        params = args.extract_options!
        photos = self.edge :photos, params, edge_scope: args.first
        photos.collect! do |photo|
          Photo.new(photo[:id], photo).authenticate self.access_token
        end
      end

      def photo!(params = {})
        photo = self.post params, edge: :photos
        Photo.new(photo[:id], params.merge(photo)).authenticate self.access_token
      end
    end
  end
end
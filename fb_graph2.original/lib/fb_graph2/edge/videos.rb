module FbGraph2
  class Edge
    module Videos
      def videos(*args)
        params = args.extract_options!
        videos = self.edge :videos, params, edge_scope: args.first
        videos.collect! do |video|
          Video.new(video[:id], video).authenticate self.access_token
        end
      end

      def video!(params = {})
        video = self.post params, edge: :videos
        Video.new(video[:id], params.merge(video)).authenticate self.access_token
      end
    end
  end
end
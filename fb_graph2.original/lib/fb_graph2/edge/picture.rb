module FbGraph2
  class Edge
    module Picture
      def picture(*args)
        params = args.extract_options!
        params[:type] = args.first if args.first
        picture = self.get params.merge(redirect: false), edge: :picture
        Struct::Picture.new picture[:data]
      end
    end
  end
end
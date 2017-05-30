module FbGraph2
  class Edge
    module Picture
      def assign(attributes)
        super
        if attributes.include? :picture
          @_cached_picture = attributes[:picture]
        end
      end

      def picture(*args)
        params = args.extract_options!
        params[:type] = args.first if args.first
        picture = if @_cached_picture.present? && params.blank?
          @_cached_picture
        else
          self.get params.merge(redirect: false), edge: :picture
        end
        Struct::Picture.new picture[:data]
      end
    end
  end
end
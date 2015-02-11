module FbGraph2
  class Collection < Array
    attr_accessor :before, :after, :next, :previous, :total_count, :summary

    def initialize(collection = [])
      collection = normalize collection
      paginate collection[:paging]
      summarize collection[:summary]
      replace Array(collection[:data])
    end

    private

    def normalize(collection)
      case collection
      when Hash
        collection
      when Array
        {
          data:  collection,
          count: collection.size
        }
      else
        raise ArgumentError.new("Invalid collection")
      end
    end

    def paginate(paging)
      cursors  = paging.try(:[], :cursors)
      self.before   = cursors.try(:[], :before)
      self.after    = cursors.try(:[], :after)
      self.next     = params_in paging.try(:[], :next)
      self.previous = params_in paging.try(:[], :previous)
    end

    def summarize(summary)
      self.summary     = summary
      self.total_count = summary.try(:[], :total_count)
      if summary.try(:[], :updated_time)
        self.summary[:updated_time] = Time.parse summary[:updated_time]
      end
    end

    def params_in(url)
      if url
        Rack::Utils.parse_nested_query(
          URI.parse(url).query
        ).inject({}) do |params, (key, value)|
          params.merge! key => value
        end.with_indifferent_access
      end
    end
  end
end

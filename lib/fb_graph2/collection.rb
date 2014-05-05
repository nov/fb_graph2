module FbGraph2
  class Collection < Array
    attr_reader :previous, :next, :total_count, :unread_count, :updated_time, :cursors

    def initialize(collection = nil)
      collection = case collection
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
      replace Array(collection[:data])
    end
  end
end

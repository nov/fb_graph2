module FbGraph2
  module Searchable
    class Result < Collection
      attr_accessor :query, :access_token, :klass, :collection, :options

      def initialize(query, access_token, klass, options = {})
        @klass = klass
        @access_token = access_token
        @query = query
        @options = options
        @collection = options.delete(:collection) || Collection.new
        replace @collection
      end

      def next(_options_ = {})
        if collection.next.present?
          klass.search query, access_token, options.merge(_options_).merge(collection.next)
        else
          self.class.new query, access_token, klass
        end
      end

      def previous(_options_ = {})
        if collection.previous.present?
          klass.search query, access_token, options.merge(_options_).merge(collection.previous)
        else
          self.class.new query, access_token, klass
        end
      end
    end
  end
end
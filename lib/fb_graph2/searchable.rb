module FbGraph2
  module Searchable
    def self.search(query, access_token, options = {})
      klass = options.delete(:class) || Searchable
      collection = Collection.new(
        Node.new(:search).authenticate(
          access_token
        ).send(:get, options.merge(q: query))
      )
      yield collection if block_given?
      Searchable::Result.new(query, access_token, klass, options.merge(:collection => collection))
    end

    def search(query, access_token, options = {})
      type = self.to_s.split('::').last.underscore
      Searchable.search(query, access_token, options.merge(:type => type, :class => self)) do |collection|
        collection.map! do |obj|
          self.new(obj[:id], obj.merge(
            :access_token => options[:access_token]
          ))
        end
      end
    end
  end
end

require 'fb_graph2/searchable/result'

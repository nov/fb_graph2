module FbGraph2
  class Edge < Collection
    attr_accessor :owner, :edge, :params, :options, :collection
    delegate :summary, :total_count, to: :collection

    def initialize(owner, edge, params = {}, options = {})
      self.owner = owner
      self.edge = edge
      self.params = params
      self.options = options
      self.collection = options.delete(:collection) || Collection.new
      replace collection
    end

    def next(_options_ = {})
      if collection.next.present?
        owner.send edge, options.merge(collection.next).merge(_options_)
      elsif collection.after.present?
        owner.send edge, options.merge(after: collection.after).merge(_options_)
      else
        self.class.new owner, edge
      end
    end

    def previous(_options_ = {})
      if self.collection.previous.present?
        owner.send edge, options.merge(collection.previous).merge(_options_)
      elsif collection.before.present?
        owner.send edge, options.merge(before: collection.before).merge(_options_)
      else
        self.class.new owner, edge
      end
    end
  end
end

Dir[File.join(__dir__, 'edge/*.rb')].each do |file|
  require file
end
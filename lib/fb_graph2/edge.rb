module FbGraph2
  class Edge < Collection
    attr_accessor :owner, :edge, :params, :options, :collection

    def initialize(owner, edge, params = {}, options = {})
      self.owner = owner
      self.edge = edge
      self.params = params
      self.options = options
      self.collection = options.delete(:collection) || Collection.new
      replace collection
    end
  end
end

Dir[File.join(__dir__, 'edge/*.rb')].each do |file|
  require file
end
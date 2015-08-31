module FbGraph2
  class Struct
    include AttributeAssigner

    def initialize(attributes = {})
      assign attributes
    end
  end
end

Dir[File.join(File.dirname(__FILE__), 'struct/*.rb')].each do |file|
  require file
end

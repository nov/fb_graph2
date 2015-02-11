module FbGraph2
  class Struct
    def self.inherited(klass)
      klass.send :include, AttributeAssigner
    end

    def initialize(attributes = {})
      assign attributes if respond_to? :assign
    end
  end
end

Dir[File.join(__dir__, 'struct/*.rb')].each do |file|
  require file
end
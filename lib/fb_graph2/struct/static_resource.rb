module FbGraph2
  class Struct
    class StaticResource < Struct
      register_attributes(
        raw: [:usage_stats, :prefetched_resources],
        custom: [:https]
      )

      def initialize(attributes = {})
        super
        if attributes.include? :https
          self.https = self.class.new attributes[:https]
        end
      end
    end
  end
end
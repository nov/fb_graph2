module FbGraph2
  module AttributeAssigner
    extend ActiveSupport::Concern

    included do
      cattr_accessor :registered_attributes
    end

    def assign(attributes)
      self.class.registered_attributes.each do |type, keys|
        keys.each do |key|
          raw = attributes[key]
          if raw.present?
            value = case type
            when :raw
              raw
            when :date
              Date.parse raw
            when :time
              Time.parse raw
            when :custom
              # TODO:
            end
            self.send :"#{key}=", attributes[key]
          end
        end
      end
    end
  end
end
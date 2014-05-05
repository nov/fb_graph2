module FbGraph2
  module AttributeAssigner
    extend ActiveSupport::Concern

    included do
      extend ClassMethods
      attr_accessor :raw_attributes
      cattr_accessor :registered_attributes
    end

    module ClassMethods
      def register_attributes(attributes)
        self.registered_attributes = attributes
        send :attr_accessor, *attributes.values.flatten
      end
    end

    def assign(attributes)
      self.raw_attributes = attributes
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
            when :page
              Page.new raw[:id], raw
            when :pages
              raw.each do |_raw_|
                Page.new _raw_[:id], _raw_
              end
            when :user
              User.new raw[:id], raw
            when :custom
              # NOTE: handle custom attributes in each class
            end
            self.send :"#{key}=", attributes[key]
          end
        end
      end
    end
  end
end
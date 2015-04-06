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
      Array(self.class.registered_attributes).each do |type, keys|
        keys.each do |key|
          if attributes.include? key
            raw = attributes[key]
            value = case type
            when :raw
              raw
            when :int_flag
              raw == 1
            when :date
              Date.strptime raw, '%m/%d/%Y' rescue raw
            when :time
              Time.parse raw rescue raw
            when :timestamp
              Time.at raw
            when :actions
              Collection.new(raw).collect! do |_raw_|
                Struct::Action.new _raw_
              end
            when :album
              Album.new raw[:id], raw
            when :app
              App.new raw[:id], raw
            when :comment
              Comment.new raw[:id], raw
            when :group
              Group.new raw[:id], raw
            when :image_sources
              Collection.new(raw).collect! do |_raw_|
                Struct::ImageSource.new _raw_
              end
            when :messages
              Collection.new(raw).collect! do |_raw_|
                Message.new _raw_[:id], _raw_
              end
            when :location
              Struct::Location.new raw
            when :page
              Page.new raw[:id], raw
            when :pages
              Collection.new(raw).collect! do |_raw_|
                Page.new _raw_[:id], _raw_
              end
            when :photo
              Photo.new raw[:id], raw
            when :picture
              Struct::Picture.new raw[:data]
            when :profile
              as_profile raw
            when :profiles
              Collection.new(raw).collect! do |_raw_|
                as_profile _raw_
              end
            when :user
              User.new raw[:id], raw
            when :users
              Collection.new(raw).collect! do |_raw_|
                User.new _raw_[:id], _raw_
              end
            when :tags
              Collection.new(raw).collect! do |_raw_|
                Struct::Tag.new _raw_
              end
            else
              # NOTE: handle these attributes in each class
              next
            end
            self.send :"#{key}=", value
          end
        end
      end
    end

    private

    def as_profile(raw)
      klass = if raw.include? :namespace
        App
      elsif raw.include? :category
        Page
      elsif raw.include? :start_time
        Event
      elsif raw.include? :owner
        Group
      else
        User
      end
      klass.new raw[:id], raw
    end
  end
end
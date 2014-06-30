module FbGraph2
  class TaggedProfile < Node
    register_attributes(
      raw: [:id, :name, :type, :offset, :length],
      custom: [:object]
    )

    def initialize(id, attributes = {})
      super
      self.object = klass.new self.id
    end

    def klass
      klass = case self.type
      when 'user'
        User
      when 'page'
        Page
      when 'group'
        Group
      when 'event'
        Event
      end
    end
  end
end
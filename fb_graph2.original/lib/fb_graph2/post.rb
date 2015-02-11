module FbGraph2
  class Post < Node
    include Edge::Comments
    include Edge::Insights
    include Edge::Likes::LikeeContext
    include Edge::SharedPosts

    register_attributes(
      raw: [
        :caption, :description, :icon, :is_hidden, :link, :message, :name, :object_id, :picture,
        :source, :status_type, :story, :type
      ],
      time: [:created_time, :updated_time],
      app: [:application],
      page: [:place],
      profile: [:from],
      profiles: [:to, :with_tags],
      actions: [:actions],
      custom: [
        :message_tags, :privacy, :properties
      ]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :message_tags
        self.message_tags = attributes[:message_tags].inject({}) do |message_tags, (key, values)|
          _message_tags_ = values.collect do |value|
            TaggedProfile.new value[:id], value
          end
          message_tags.merge! key => _message_tags_
        end
      end
      if attributes.include? :privacy
        self.privacy = Struct::Privacy.new attributes[:privacy]
      end
      if attributes.include? :properties
        self.properties = attributes[:properties].collect do |property|
          Struct::Property.new property
        end
      end
    end
  end
end
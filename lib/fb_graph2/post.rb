module FbGraph2
  class Post < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext
    include Edge::SharedPosts

    register_attributes(
      raw: [
        :caption, :description, :icon, :is_hidden, :link, :message, :name, :object_id, :picture,
        :source, :story, 
        :privacy, :shares, :status_type, :type
      ],
      time: [:created_time, :updated_time],
      app: [:application],
      page: [:place],
      profile: [:from],
      profiles: [:to, :with_tags],
      actions: [:actions],
      custom: [
        :message_tags, :properties      
      ]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :message_tags
        self.message_tags =  attributes[:message_tags].collect do |message_tag|
          Struct::MessageTag.new message_tag
        end
      end
      if attributes.include? :properties
        self.properties = attributes[:properties].collect do |property|
          Struct::Property.new property
        end
      end
    end
  end
end

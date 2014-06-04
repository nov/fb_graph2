module FbGraph2
  class Post < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext
    include Edge::SharedPosts

    register_attributes(
      raw: [
        :caption, :description, :icon, :is_hidden, :link, :message, :name, :object_id, :picture,
        :source, :story
      ],
      time: [:created_time, :updated_time],
      app: [:application],
      page: [:place],
      profile: [:from],
      profiles: [:to, :with_tags],
      actions: [:actions],
      custom: [
        :message_tags, :privacy, :properties, :shares, :status_type, :type
      ]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end
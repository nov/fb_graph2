module FbGraph2
  class Post < Node
    register_attributes(
      raw: [
        :caption, :description, :icon, :is_hidden, :link, :message, :name, :object_id, :picture,
        :source, :story
      ],
      time: [:created_time, :updated_time],
      application: [:application],
      page: [:place],
      profile: [:from],
      profiles: [:to, :with_tags],
      custom: [
        :actions, :message_tags, :privacy, :properties, :shares, :status_type, :type
      ]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end
module FbGraph2
  class Achievement < Node
    include Edge::Comments
    include Edge::Likes::LikeeContext

    register_attributes(
      raw: [:type, :no_feed_story],
      time: [:publish_time],
      app: [:application],
      user: [:from],
      custom: [:data]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :data
        self.data = attributes[:data]
      end
    end
  end
end
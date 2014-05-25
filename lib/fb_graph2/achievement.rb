module FbGraph2
  class Achievement < Node
    register_attributes(
      raw: [:type, :no_feed_story],
      time: [:publish_time],
      application: [:application],
      user: [:from],
      custom: [:data]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end
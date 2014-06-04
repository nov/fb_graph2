module FbGraph2
  class Notification < Node
    register_attributes(
      raw: [:title, :link, :unread],
      time: [:created_time, :updated_time],
      profile: [:from],
      user: [:to],
      app: [:application],
      custom: [:object]
    )

    def initialize(id, attributes = {})
      super
      # TODO: handle custom attributes.
    end
  end
end
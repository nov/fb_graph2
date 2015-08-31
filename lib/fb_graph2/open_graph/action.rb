module FbGraph2
  module OpenGraph
    class Action < Node
      include Edge::Comments
      include Edge::Likes::LikeeContext

      register_attributes(
        raw: [:message, :no_feed_story, :ref, :type],
        time: [:end_time, :publish_time, :start_time],
        app: [:application],
        profile: [:from],
        custom: [:object]
      )

      def initialize(id, attributes = {})
        super
        if attributes.include?(:data) && attributes[:data].include?(:object)
          _object_ = attributes[:data][:object]
          self.object = OpenGraph::Object.new _object_[:id], _object_
        end
      end
    end
  end
end
module FbGraph2
  class Insight < Node
    register_attributes(
      raw: [:name, :description, :title, :period],
      custom: [:values]
    )

    def initialize(id, attributes = {})
      super
      self.values = attributes[:values].collect(&:with_indifferent_access)
    end
  end
end
module FbGraph2
  class Domain < Node
    include Edge::Insights

    register_attributes(
      raw: [:name]
    )
  end
end
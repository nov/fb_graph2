module FbGraph2
  class Translation < Node
    register_attributes(
      raw: [:translation, :approval_status, :native_string, :description]
    )
  end
end
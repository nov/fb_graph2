module FbGraph2
  class DebugToken < Node
    register_attributes(
      raw: [
        :app_id, :application, :error, :is_valid, :metadata, :profile_id, :scopes, :user_id
      ],
      timestamp: [:expires_at, :issued_at]
    )

    def initialize(attributes = {})
      super :debug_token, attributes
    end

    def fetch(params = {}, options = {})
      attributes = get params, options
      self.class.new(attributes[:data])
    end
  end
end
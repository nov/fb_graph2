module FbGraph2
  class TokenMetadata < Node
    register_attributes(
      raw: [
        :app_id, :application, :error, :is_valid, :metadata, :profile_id, :scopes, :user_id
      ],
      timestamp: [:expires_at, :issued_at],
      custom: [:app, :user, :page]
    )

    def initialize(attributes = {})
      super :debug_token, attributes
      if app_id
        self.app = App.new app_id
      end
      if user_id
        self.user = User.new user_id
      end
      if profile_id
        self.page = Page.new profile_id
      end
    end

    def fetch(params = {}, options = {})
      attributes = get params, options
      self.class.new(attributes[:data]).authenticate access_token
    end

    def valid?
      !!is_valid
    end

    def app_token?
      app.present? && user.blank? && page.blank?
    end

    def user_token?
      app.present? && user.present? && page.blank?
    end

    def page_token?
      app.present? && user.present? && page.present?
    end
  end
end
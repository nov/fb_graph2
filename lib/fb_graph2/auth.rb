module FbGraph2
  class Auth < Rack::OAuth2::Client
    def initialize(client_id, client_secret, options = {})
      super options.merge(
        identifier: client_id,
        secret: client_secret,
        host: URI.parse(FbGraph2.root_url).host,
        authorize_endpoint: '/oauth/authorize',
        token_endpoint: '/oauth/access_token'
      )
    end
  end
end
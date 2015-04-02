module FbGraph2
  class Auth < Rack::OAuth2::Client
    class Grant
      class FbExchangeToken < Rack::OAuth2::Client::Grant
        attr_required :fb_exchange_token
      end
    end

    def initialize(client_id, client_secret, options = {})
      super options.merge(
        identifier: client_id,
        secret: client_secret,
        host: URI.parse(FbGraph2.root_url).host,
        authorization_endpoint: '/oauth/authorize',
        token_endpoint: '/oauth/access_token'
      )
    end

    def fb_exchange_token=(access_token)
      @grant = Grant::FbExchangeToken.new(
        fb_exchange_token: access_token
      )
    end

    def access_token!(options = {})
      super options.merge(
        client_auth_method: :body
      )
    rescue Rack::OAuth2::Client::Error => e
      raise Exception.detect(e.status, e.response)
    end

    def debug_token!(input_token)
      token_metadata = TokenMetadata.new
      token_metadata.authenticate access_token!
      token_metadata.fetch(
        input_token: input_token.to_s
      )
    end

    def from_cookie(cookie)
      token = case cookie
      when String
        cookie
      else
        cookie["fbsr_#{identifier}"]
      end
      from_signed_request token
    end

    def from_signed_request(token)
      SignedRequest.new(token).verify! self
    end
  end
end

Dir[File.join(__dir__, 'auth/*.rb')].each do |file|
  require file
end

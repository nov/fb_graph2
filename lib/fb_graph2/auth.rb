module FbGraph2
  class Auth < Rack::OAuth2::Client
    attr_required :client_code_endpoint

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
        authorization_endpoint: File.join('/', FbGraph2.api_version, '/oauth/authorize'),
        token_endpoint: File.join('/', FbGraph2.api_version, '/oauth/access_token'),
        client_code_endpoint: File.join('/', FbGraph2.api_version, '/oauth/client_code')
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

    def client_code!(access_token, options = {})
      params = {
        access_token: access_token,
        client_id: identifier,
        client_secret: secret,
        redirect_uri: redirect_uri
      }.merge(options)
      response = Rack::OAuth2.http_client.post(
        absolute_uri_for(client_code_endpoint),
        params
      )
      response_json = JSON.parse(response.body).with_indifferent_access
      case response.status
      when 200..201
        response_json
      else
        raise Exception.detect(response.status, response_json)
      end
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
        cookie.delete "fbsr_#{identifier}"
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

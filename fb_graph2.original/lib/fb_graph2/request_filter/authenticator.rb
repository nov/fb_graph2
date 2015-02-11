module FbGraph2
  module RequestFilter
    class Authenticator < Rack::OAuth2::AccessToken::Authenticator
      def initialize(access_token)
        _access_token_ = case access_token
        when Rack::OAuth2::AccessToken
          access_token
        else
          Rack::OAuth2::AccessToken::Bearer.new(
            access_token: access_token
          )
        end
        super _access_token_
      end
    end
  end
end
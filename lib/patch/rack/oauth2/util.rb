# NOTE: Authorization code given via FB JS SDK needs blank string as redirect_uri

module Rack::OAuth2::Util
  class << self
    module ComcactHashWithBrankRedirect
      def compact_hash(hash)
        original_redirect_uri = hash[:redirect_uri]
        result = super
        if original_redirect_uri
          result[:redirect_uri] ||= original_redirect_uri
        end
        result
      end
    end
    prepend ComcactHashWithBrankRedirect
  end
end
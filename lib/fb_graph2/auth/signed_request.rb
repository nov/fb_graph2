require 'url_safe_base64'

module FbGraph2
  class Auth
    class SignedRequest
      class VerificationFailed < Exception::BadRequest; end

      attr_accessor :payload, :access_token, :user

      def initialize(token)
        signature_str, @payload_str = token.split('.', 2)
        @signature = UrlSafeBase64.decode64 signature_str
        payload_json = UrlSafeBase64.decode64 @payload_str
        self.payload = MultiJson.load(payload_json).with_indifferent_access
      rescue => e
        raise VerificationFailed.new 'Decode failed'
      end

      def verify!(client)
        digest = OpenSSL::Digest::SHA256.new
        signature = OpenSSL::HMAC.digest OpenSSL::Digest::SHA256.new, client.secret, @payload_str
        raise VerificationFailed.new('Verification failed') unless @signature == signature
        instantiate client
      end

      private

      def instantiate(client)
        if payload[:code].present?
          client.authorization_code = payload[:code]
          self.access_token = client.access_token!
        else
          self.access_token = payload[:oauth_token]
        end
        self.user = User.new(payload[:user_id], payload[:user] || {}).authenticate(access_token)
        self
      end
    end
  end
end
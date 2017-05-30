module FbGraph2
  class Exception < StandardError
    attr_accessor :status, :type, :code, :error_subcode
    alias_method :error_code, :code

    class << self
      def detect(status, body = {}, headers = {})
        error = body[:error]
        message = error.try(:[], :message)
        klass = detect_from_header(headers, error) || detect_from_status(status)
        if klass
          klass.new message, error
        else
          new status, message, error
        end
      end

      def detect_from_status(status)
        case status
        when 400
          BadRequest
        when 401
          Unauthorized
        when 404
          NotFound
        when 500
          InternalServerError
        end
      end

      def detect_from_header(headers, error)
        key, value = headers.detect do |name, value|
          name.upcase == "WWW-Authenticate".upcase
        end || return
        matched, klass = ERROR_HEADER_MATCHERS.detect do |matcher, klass_name|
          matcher =~ value
        end || return
        klass
      end
    end

    def initialize(status, message, error = {})
      super message
      self.status = status
      self.type = error[:type]
      self.code = error[:code]
      self.error_subcode = error[:error_subcode]
    end

    class BadRequest < Exception
      def initialize(message, details = {})
        super 400, message, details
      end
    end

    class Unauthorized < Exception
      def initialize(message, details = {})
        super 401, message, details
      end
    end

    class NotFound < Exception
      def initialize(message, details = {})
        super 404, message, details
      end
    end

    class InternalServerError < Exception
      def initialize(message, details = {})
        super 500, message, details
      end
    end

    class InvalidToken < Unauthorized; end
    class InvalidRequest < BadRequest; end

    ERROR_HEADER_MATCHERS = {
      /not_found/       => NotFound,
      /invalid_token/   => InvalidToken,
      /invalid_request/ => InvalidRequest
    }
  end
end

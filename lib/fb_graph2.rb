require 'active_support/all'
require 'rack/oauth2'

module FbGraph2
  VERSION = File.read(File.join(__dir__, '../VERSION')).delete("\n\r")
  ROOT_URL = 'https://graph.facebook.com/v2.0'

  cattr_accessor :logger, :debugging, :_http_config_
  self.logger = Logger.new(STDOUT)
  self.logger.progname = 'FbGraph2'

  class << self
    def debugging?
      !!self.debugging
    end
    def debug!
      Rack::OAuth2.debug!
      self.debugging = true
    end

    def http_client(access_token = nil)
      _http_client_ = HTTPClient.new(
        agent_name: "FbGraph2 (#{VERSION})"
      )
      _http_client_.request_filter << RequestFilters::Authenticator.new(access_token) if access_token.present?
      _http_client_.request_filter << RequestFilters::Debugger.new if self.debugging?
      _http_config_.try(:call, _http_client_)
      _http_client_
    end
    def http_config(&block)
      Rack::OAuth2.http_config &block unless Rack::OAuth2.http_config
      self._http_config_ ||= block
    end
  end
end

require 'fb_graph2/node'
Dir[File.dirname(__FILE__) + '/fb_graph2/*.rb'].each do |file|
  require file
end
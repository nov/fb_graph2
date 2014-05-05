require 'active_support/all'
require 'rack/oauth2'

module FbGraph2
  cattr_accessor :api_version, :gem_version, :logger, :debugging, :_http_config_

  self.api_version = 'v2.0'
  self.gem_version = File.read(File.join(__dir__, '../VERSION')).delete("\n\r")
  self.logger = Logger.new(STDOUT)
  self.logger.progname = 'FbGraph2'

  class << self
    def root_url
      File.join('https://graph.facebook.com', api_version)
    end

    def debugging?
      !!self.debugging
    end
    def debug!
      Rack::OAuth2.debug!
      self.debugging = true
    end

    def http_client(access_token = nil)
      _http_client_ = HTTPClient.new(
        agent_name: "FbGraph2 (#{gem_version})"
      )
      _http_client_.request_filter.delete_if do |filter|
        filter.is_a? HTTPClient::WWWAuth
      end
      _http_client_.request_filter << RequestFilter::Authenticator.new(access_token) if access_token.present?
      _http_client_.request_filter << RequestFilter::Debugger.new if self.debugging?
      _http_config_.try(:call, _http_client_)
      _http_client_
    end
    def http_config(&block)
      Rack::OAuth2.http_config &block unless Rack::OAuth2.http_config
      self._http_config_ ||= block
    end
  end
end

require 'fb_graph2/attribute_assigner'
require 'fb_graph2/node'
require 'fb_graph2/collection'
require 'fb_graph2/edge'
[
  '.',
  'request_filter'
].each do |dir|
  Dir[File.join(__dir__, 'fb_graph2', dir, '*.rb')].each do |file|
    require file
  end
end

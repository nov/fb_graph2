module FbGraph2
  class Node
    attr_accessor :id, :access_token, :raw_attributes

    def initialize(id, attributes = {})
      self.id = id
      self.raw_attributes = attributes
      self.access_token = attributes[:access_token]
    end

    def fetch(params = {}, options = {})
      self.access_token ||= options[:access_token]
      _fetched_ = get params, options
      _fetched_[:access_token] ||= self.access_token
      self.class.new(_fetched_[:id], _fetched_)
    end

    def self.fetch(identifier, options = {})
      new(identifier).fetch(options)
    end

    protected

    def http_client
      FbGraph2.http_client(access_token)
    end

    def get(params = {}, options = {})
      handle_response do
        http_client.get build_endpoint(options), build_params(params)
      end
    end

    private

    def build_endpoint(options = {})
      File.join [
        File.join(FbGraph2.root_url, id.to_s),
        options[:connection],
        options[:connection_scope]
      ].compact.collect(&:to_s)
    end

    def build_params(params = {})
      params.present? ? params : nil
    end

    def handle_response
      response = yield
      _response_ = MultiJson.load(response.body).with_indifferent_access
      case response.status
      when 200...300
        _response_
      else
        raise response.body
      end
    rescue MultiJson::DecodeError
      raise Exception.new(response.status, "Unparsable Response: #{response.body}")
    end
  end
end
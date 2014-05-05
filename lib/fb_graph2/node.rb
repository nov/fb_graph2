module FbGraph2
  class Node
    include AttributeAssigner
    attr_accessor :id, :access_token, :raw_attributes

    def initialize(id, attributes = {})
      self.id = id
      assign attributes
    end

    def authenticate(access_token)
      self.access_token = access_token
      self
    end

    def fetch(params = {})
      attributes = get params
      self.class.new(attributes[:id], attributes).authenticate access_token
    end

    def self.fetch(identifier, params = {})
      new(identifier).fetch params
    end

    def edge(edge, params = {}, options = {})
      Edge.new(
        self,
        edge,
        params,
        options.merge(
          collection: edge_for(edge, params, options)
        )
      )
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

    def edge_for(edge, params = {}, options = {})
      collection = get params, options.merge(:edge => edge)
      Collection.new collection
    end

    def build_endpoint(options = {})
      File.join [
        File.join(FbGraph2.root_url, id.to_s),
        options[:edge],
        options[:edge_scope]
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
module FbGraph2
  class Node
    attr_accessor :id, :access_token, :raw_attributes
    alias_method :identifier, :id

    def self.inherited(klass)
      klass.send :include, AttributeAssigner
      FbGraph2.object_classes << klass
    end

    def initialize(id, attributes = {})
      self.id = id
      self.raw_attributes = attributes
      assign attributes if respond_to? :assign
      authenticate attributes[:access_token] if attributes.include? :access_token
    end

    def authenticate(access_token)
      self.access_token = access_token
      self
    end

    def fetch(params = {}, options = {})
      attributes = get params, options
      self.class.new(attributes[:id], attributes).authenticate access_token
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

    def edges
      @edges ||= self.class.included_modules.select do |_module_|
        _module_.name =~ /FbGraph2::Edge/
      end.collect(&:instance_methods).flatten.sort
    end

    def update(params = {}, options = {})
      post params, options
    end

    def destroy(params = {}, options = {})
      delete params, options
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

    def post(params = {}, options = {})
      handle_response do
        http_client.post build_endpoint(options), build_params(params)
      end
    end

    def delete(params = {}, options = {})
      handle_response do
        http_client.delete build_endpoint(options), build_params(params)
      end
    end

    private

    def edge_for(edge, params = {}, options = {})
      collection = get params, options.merge(edge: edge)
      Collection.new collection
    end

    def build_endpoint(options = {})
      File.join [
        File.join(
          FbGraph2.root_url,
          options[:api_version] || FbGraph2.api_version,
          id.to_s
        ),
        options[:edge],
        Util.as_identifier(options[:edge_scope])
      ].compact.collect(&:to_s)
    end

    def build_params(params = {})
      params = Hash(params).merge(debug: :all) if FbGraph2.debugging?
      if params.present?
        if params.include? :fields
          params[:fields] = Array(params[:fields]).join(',')
        end
        params
      else
        nil
      end
    end

    def handle_response
      response = yield
      _response_ = MultiJson.load response.body
      _response_ = _response_.with_indifferent_access if _response_.respond_to? :with_indifferent_access
      case response.status
      when 200...300
        if _response_.respond_to?(:has_key?) && _response_.has_key?(:success)
          _response_[:success]
        else
          _response_
        end
      else
        raise Exception.detect(response.status, _response_, response.headers)
      end
    rescue MultiJson::DecodeError
      raise Exception.new(response.status, "Unparsable Response: #{response.body}")
    end
  end
end

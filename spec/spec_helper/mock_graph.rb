require 'webmock/rspec'

module MockGraph
  def mock_graph(method, path, response_path, options = {})
    stub_request(
      method,
      endpoint_for(path, options)
    ).with(
      request_for(method, options)
    ).to_return(
      response_for(response_path, options)
    )
    if block_given?
      response = yield
      a_request(
        method,
        endpoint_for(path, options)
      ).with(
        request_for(method, options)
      ).should have_been_made.once
      response
    end
  end

  def mock_json(response_path)
    content = response_for(response_path)[:body].read
    MultiJson.load(content).with_indifferent_access
  rescue MultiJson::DecodeError
    content
  end

  def request_to(path, method = :get, options = {})
    raise_error { |e|
      e.should be_instance_of WebMock::NetConnectNotAllowedError
      e.message.should include("Unregistered request: #{method.to_s.upcase}")
      e.message.should include(endpoint_for path, options)
    }
  end

  private

  def endpoint_for(path, options = {})
    api_version = unless options[:disable_api_versioning]
      options[:api_version] || FbGraph2.api_version
    end
    File.join FbGraph2.root_url, api_version.to_s, path
  end

  def request_for(method, options = {})
    request = {}
    if options[:access_token]
      request[:headers] ||= {}
      request[:headers] = {
        authorization: "Bearer #{options[:access_token]}"
      }
    end
    params = options.try(:[], :params) || {}
    case method
    when :post, :put, :delete
      request[:body] = params
    else
      request[:query] = params
    end
    request
  end

  def response_for(response_path, options = {})
    response = {}
    response[:body] = response_file_for response_path
    if options[:status]
      response[:status] = options[:status]
    end
    response
  end

  def response_file_for(response_path)
    _response_file_path_ = if File.exist? response_path
      response_path
    else
      File.join(
        File.dirname(__FILE__), '../mock_json', "#{response_path}.json"
      )
    end
    unless File.exist? _response_file_path_
      response_file_required! _response_file_path_
    end
    File.new _response_file_path_, 'r', encoding: 'utf-8'
  end

  def response_file_required!(response_path)
    warn 'No response file found.'
  end
end

include MockGraph
WebMock.disable_net_connect!
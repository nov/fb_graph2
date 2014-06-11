require 'spec_helper'

describe FbGraph2::RequestFilter::Authenticator do
  let(:klass)    { FbGraph2::RequestFilter::Authenticator }

  let(:endpoint) { 'https://graph.facebook.com/matake' }
  let(:request)  { HTTP::Message.new_request(:get, URI.parse(endpoint)) }
  let(:request_filter) { klass.new token }

  context 'when String given' do
    let(:token) { 'token' }
    it do
      request_filter.filter_request(request)
      request.header["Authorization"].should == ["Bearer #{token}"]
    end
  end

  context 'when Rack::OAuth2::AccessToken::Bearer given' do
    let(:token) { Rack::OAuth2::AccessToken::Bearer.new access_token: 'token' }
    it do
      request_filter.filter_request(request)
      request.header["Authorization"].should == ["Bearer #{token.access_token}"]
    end
  end

  context 'when Rack::OAuth2::AccessToken::Legacy given' do
    let(:token) { Rack::OAuth2::AccessToken::Legacy.new access_token: 'token' }
    it do
      request_filter.filter_request(request)
      request.header["Authorization"].should == ["OAuth #{token.access_token}"]
    end
  end
end
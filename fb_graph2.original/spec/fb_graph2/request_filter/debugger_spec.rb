require 'spec_helper'

describe FbGraph2::RequestFilter::Debugger do
  let(:endpoint) { 'https://graph.facebook.com/matake' }
  let(:request)  { HTTP::Message.new_request(:get, URI.parse(endpoint)) }
  let(:response) { HTTP::Message.new_response({:hello => 'world'}.to_json) }
  let(:request_filter) { FbGraph2::RequestFilter::Debugger.new }

  describe '#filter_request' do
    it 'should log request' do
      [
        "======= [FbGraph2] API REQUEST STARTED =======",
        request.dump
      ].each do |output|
        expect(FbGraph2.logger).to receive(:info).with output
      end
      request_filter.filter_request(request)
    end
  end

  describe '#filter_response' do
    it 'should log response' do
      [
        "--------------------------------------------------",
        response.dump,
        "======= [FbGraph2] API REQUEST FINISHED ======="
      ].each do |output|
        expect(FbGraph2.logger).to receive(:info).with output
      end
      request_filter.filter_response(request, response)
    end
  end
end
require 'spec_helper'

describe FbGraph2::Exception do
  it 'should properly set its message for inspect' do
    err = FbGraph2::Exception.new(400, 'This is the error message')
    err.inspect.should == '#<FbGraph2::Exception: This is the error message>'
  end

  context 'when response body is given' do
    it 'should setup type, error code, and subcode from error' do
      err = FbGraph2::Exception.new(400, 'This is the original message',
         {
          :type => 'SomeError',
          :message => 'This is the error message',
          :code => 190,
          :error_subcode => 460
        }
      )
      err.status.should == 400
      err.type.should == 'SomeError'
      err.error_code.should == 190
      err.error_subcode.should == 460
    end
  end

  describe ".detect" do
    it 'should detect the appropriate class from the error status' do
      [400,401,404,500].each do |error_code|
        err = FbGraph2::Exception.detect(error_code, error: { message: "Error #{error_code}"})
        err.class.should == FbGraph2::Exception.detect_from_status(error_code)
      end
    end

    it 'should detect the appropriate class from headers' do
      %w{not_found invalid_token, invalid_request}.each do |error|
        header = {"WWW-Authenticate" => "OAuth 'Facebook Platform' '#{error}' Error!"}
        err = FbGraph2::Exception.detect('a code', {error: {message: "an error occurred"}}, header)
        err.class.should == FbGraph2::Exception.detect_from_header(header, nil)
      end
    end

  end
end

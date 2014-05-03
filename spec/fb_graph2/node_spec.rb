require 'spec_helper'

describe FbGraph2::Node do
  describe '.new' do
    it 'should support access_token option' do
      FbGraph2::Node.new(
        'matake', :access_token => 'access_token'
      ).access_token.should == 'access_token'
    end

    it 'should store raw attributes' do
      attributes = {:key => :value}
      FbGraph2::Node.new(12345, attributes).raw_attributes.should == attributes
    end
  end
end
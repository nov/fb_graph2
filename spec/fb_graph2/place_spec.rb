require 'spec_helper'

describe FbGraph2::Place do
  subject { described_class }
  its(:registered_attributes) { should == FbGraph2::Page.registered_attributes }
end
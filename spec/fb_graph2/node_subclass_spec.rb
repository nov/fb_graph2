require 'spec_helper'

module FbGraph2
  class NodeSubClass < Node
  end
end

describe FbGraph2::NodeSubClass do
  it 'should be included in FbGraph2.object_classes' do
    FbGraph2.object_classes.should include described_class
  end
end
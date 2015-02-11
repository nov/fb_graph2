require 'spec_helper'

module FbGraph2
  class NodeSubClass < Node
  end
end

describe FbGraph2::NodeSubClass do
  let(:klass) { FbGraph2::NodeSubClass }
  let(:instance) { klass.new 'identifier' }

  context 'class' do
    subject { klass }
    it { should respond_to :register_attributes }
    it { should respond_to :registered_attributes }
    it { should respond_to :registered_attributes= }
  end

  context 'instance' do
    subject { instance }
    it { should respond_to :assign }
  end
end
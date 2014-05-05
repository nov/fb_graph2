require 'spec_helper'

describe FbGraph2::Node do
  let(:klass) { FbGraph2::Node }
  let(:instance) { klass.new 'identifier' }

  context 'class' do
    subject { klass }
    it { should_not respond_to :register_attributes }
    it { should_not respond_to :registered_attributes }
    it { should_not respond_to :registered_attributes= }
  end

  context 'instance' do
    subject { instance }
    it { should_not respond_to :assign }

    describe '#initialize' do
      its(:id) { should == 'identifier' }
      its(:access_token) { should be_nil }
      its(:raw_attributes) { should be_nil }
    end

    describe '#authenticate' do
      before { instance.authenticate 'access_token' }
      its(:access_token) { should == 'access_token' }
    end
  end
end
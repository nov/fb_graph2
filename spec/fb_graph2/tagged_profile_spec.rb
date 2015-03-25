require 'spec_helper'

describe FbGraph2::TaggedProfile do
  describe '.initialize' do
    {
      user: FbGraph2::User,
      page: FbGraph2::Page,
      event: FbGraph2::Event,
      application: FbGraph2::App,
      unknown: FbGraph2::Node
    }.each do |type, klass|
      context "when type=#{type}" do
        it "should return instances of the #{klass}" do
          tag = FbGraph2::TaggedProfile.new(1, type: type.to_s)
          expect(tag.object).to be_a klass
        end
      end
    end
  end
end

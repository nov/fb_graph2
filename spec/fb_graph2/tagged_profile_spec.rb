require 'spec_helper'

describe FbGraph2::TaggedProfile do
  describe '.initialize' do
    it "should return instances of the appropriate classes" do
      tag_types = {
          "user" => FbGraph2::User,
          "page" => FbGraph2::Page,
          "event" => FbGraph2::Event,
          "application" => FbGraph2::App
      }

      tag_types.each do |type, klass|
        tag = FbGraph2::TaggedProfile.new(1, type: type)
        expect(tag.object).to be_a klass
      end
    end

    it "should return a Node when an unknown type is encountered" do
      tag = FbGraph2::TaggedProfile.new(1, type: "unknown")
      expect(tag.object).to be_a FbGraph2::Node
    end
  end
end

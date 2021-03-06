require 'spec_helper'

describe FbGraph2::Util do
  describe '.as_identifier' do
    context 'when FbGraph2::Node given' do
      it do
        FbGraph2::Util.as_identifier(
          FbGraph2::Node.new 'object_id'
        ).should == 'object_id'
      end
    end

    context 'when String given' do
      it do
        FbGraph2::Util.as_identifier('object_id').should == 'object_id'
      end
    end

    context 'when FbGraph2::Struct::Permission given' do
      it do
        FbGraph2::Util.as_identifier(
          FbGraph2::Struct::Permission.new(permission: 'permission_name', granted: true)
        ).should == 'permission_name'
      end
    end
  end
end
require 'spec_helper'

describe FbGraph2::Collection do
  context 'when non-collection object given' do
    it do
      expect do
        FbGraph2::Collection.new 'scalar'
      end.to raise_error ArgumentError
    end
  end
end
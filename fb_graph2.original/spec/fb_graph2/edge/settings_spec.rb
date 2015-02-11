require 'spec_helper'

describe FbGraph2::Edge::Settings do
  context 'included in Page' do
    describe '#settings' do
      let(:page) { FbGraph2::Page.new('page_id').authenticate('page_token') }
      it 'should return an Array of FbGraph2::Struct::Permission' do
        settings = mock_graph :get, 'page_id/settings', 'page/settings', access_token: 'page_token' do
          page.settings
        end
        settings.should be_instance_of FbGraph2::Edge
        settings.should_not be_blank
        settings.each do |setting|
          setting.should be_instance_of FbGraph2::Struct::Setting
        end
      end
    end
  end
end
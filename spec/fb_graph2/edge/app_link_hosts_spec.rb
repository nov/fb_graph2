require 'spec_helper'

describe FbGraph2::Edge::AppLinkHosts do
  let(:app) { FbGraph2::App.app('app_token') }

  describe '#app_link_hosts' do
    it 'should return an Array of FbGraph2::AppLinkHost' do
      mock_graph :get, 'app/app_link_hosts', 'app/app_link_hosts', access_token: 'app_token' do
        hosts = app.app_link_hosts
        hosts.should be_instance_of FbGraph2::Edge
        hosts.should_not be_blank
        hosts.each do |host|
          host.should be_instance_of FbGraph2::AppLinkHost
        end
      end
    end
  end

  describe '#app_link_host!' do
    it 'should return an FbGraph2::AppLinkHost' do
      mock_graph :post, 'app/app_link_hosts', 'success_with_id', access_token: 'app_token', params: {
        name: 'Sample',
        web: {
          should_fallback: true,
          url: 'https://fbgraphsample.herokuapp.com/app_links/sample'
        }.to_json,
        windows_phone: [{
          url: 'test://activate'
        }].to_json
      } do
        host = app.app_link_host!(
          name: 'Sample',
          web: {
            should_fallback: true,
            url: 'https://fbgraphsample.herokuapp.com/app_links/sample'
          },
          windows_phone: [{
            url: 'test://activate'
          }]
        )
        host.should be_instance_of FbGraph2::AppLinkHost
        host.id.should == 'created_object_id'
        host.name.should == 'Sample'
        host.web.should be_instance_of FbGraph2::Struct::AppLink::Web
        host.web.should_fallback.should == true
        host.web.url.should == 'https://fbgraphsample.herokuapp.com/app_links/sample'
        host.windows_phone.should be_instance_of FbGraph2::Collection
        host.windows_phone.each do |link|
          link.should be_instance_of FbGraph2::Struct::AppLink::Native::WindowsPhone
        end
        host.windows_phone.first.url.should == 'test://activate'
      end
    end
  end
end
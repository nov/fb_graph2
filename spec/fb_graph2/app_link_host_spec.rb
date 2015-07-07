require 'spec_helper'

describe FbGraph2::AppLinkHost do
  let(:app_link_host) do
    FbGraph2::AppLinkHost.new(
      'host_id',
      name: 'Sample',
      canonical_url: 'https://fb.me/804327549686491',
      ios: [{
        app_name: 'Sample iOS',
        app_store_id: 'ios.sample.fb_graph2',
        url: 'fbgraph2://ios'
      }],
      iphone: [{
        app_name: 'Sample iPhone',
        app_store_id: 'iphone.sample.fb_graph2',
        url: 'fbgraph2://iphone'
      }],
      android: [{
        app_name: 'Sample Android',
        class: 'FbGraph2',
        package: 'android.sample.fb_graph2',
        url: 'fbgraph2://android'
      }],
      windows_phone: [{
        app_name: 'Sample WindowsPhone',
        app_id: 'windows_phone.sample.fb_graph2',
        url: 'fbgraph2://windows_phone'
      }],
      web: {
        should_fallback: true,
        url: 'https://fbgraphsample.herokuapp.com/app_links/sample'
      }
    )
  end
  subject { app_link_host }

  its(:id) { should == 'host_id' }
  its(:name) { should == 'Sample' }
  its(:canonical_url) { should == 'https://fb.me/804327549686491' }

  describe 'iOS' do
    subject { app_link_host.ios.first }
    its(:app_name) { should == 'Sample iOS' }
    its(:app_store_id) { should == 'ios.sample.fb_graph2' }
    its(:url) { should == 'fbgraph2://ios' }
  end

  describe 'iPhone' do
    subject { app_link_host.iphone.first }
    its(:app_name) { should == 'Sample iPhone' }
    its(:app_store_id) { should == 'iphone.sample.fb_graph2' }
    its(:url) { should == 'fbgraph2://iphone' }
  end

  describe 'Android' do
    subject { app_link_host.android.first }
    its(:app_name) { should == 'Sample Android' }
    its(:klass) { should == 'FbGraph2' }
    its(:package) { should == 'android.sample.fb_graph2' }
    its(:url) { should == 'fbgraph2://android' }
  end

  describe 'WindowsPhone' do
    subject { app_link_host.windows_phone.first }
    its(:app_name) { should == 'Sample WindowsPhone' }
    its(:app_id) { should == 'windows_phone.sample.fb_graph2' }
    its(:url) { should == 'fbgraph2://windows_phone' }
  end
end